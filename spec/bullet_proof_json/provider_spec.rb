require "spec_helper"
require "net/http"
require "pry"

RSpec.describe BulletProofJson::Provider do

  before do
    @json_provider = BulletProofJson::Provider.new
  end

  it "has a version number" do
    expect(BulletProofJson::VERSION).not_to be nil
  end

  let(:logger) { instance_double(BulletProofJson::ConsoleLogger, error: nil, debug: nil) }
  let(:provider) { described_class.new("FAKE_API_KEY", logger) }
  let(:uri) { "https://example.com/data.json" }
  let(:project_group) { "grzegorzblaszczyk" }
  let(:project_name) { "bullet-proof-json" }
  let(:expected_user_agent) {"#{project_name} #{BulletProofJson::VERSION} - https://github.com/#{project_group}/#{project_name}"}

  before do
    allow_any_instance_of(BulletProofJson::Provider).to receive(:user_agent).and_return(expected_user_agent)
  end

  describe "#user_agent" do
    it "generates proper user_agent for Net::HTTP.get" do
      expect(@json_provider.send(:user_agent)).to eq "#{project_name} #{BulletProofJson::VERSION} - https://github.com/#{project_group}/#{project_name}"
    end
  end

  context "when request succeeds and JSON is valid" do
    it "returns parsed JSON" do
      response = '{ "foo": "bar" }'
      expect(Net::HTTP).to receive(:get).with(URI(uri), hash_including("Authorization", "User-Agent")).and_return(response)
      result = provider.get(uri)

      expect(result).to eq(JSON(response))
    end
  end

  context "when Net::ReadTimeout occurs" do
    it "retries and eventually raises ProviderError" do
      expect(Net::HTTP).to receive(:get).exactly(3).times.and_raise(Net::ReadTimeout)
      expect(logger).to receive(:error).at_least(:once)
      expect(logger).to receive(:debug).at_least(:once)

      expect {
        provider.get(uri, { max_attempts: 3, sleep_time: 0 })
      }.to raise_error(BulletProofJson::ProviderError, /Giving up after Net::ReatTimeout/)
    end
  end

  context "when Net::OpenTimeout occurs" do
    it "retries and eventually raises ProviderError" do
      expect(Net::HTTP).to receive(:get).exactly(3).times.and_raise(Net::OpenTimeout)
      expect(logger).to receive(:error).at_least(:once)
      expect(logger).to receive(:debug).at_least(:once)

      expect {
        provider.get(uri, { max_attempts: 3, sleep_time: 0 })
      }.to raise_error(BulletProofJson::ProviderError, /Giving up after Net::OpenTimeout/)
    end
  end

  context "when JSON::ParserError occurs" do
    it "retries and eventually raises ProviderError" do
      expect(Net::HTTP).to receive(:get).exactly(3).times.and_return("invalid_json")
      expect(logger).to receive(:error).at_least(:once)
      expect(logger).to receive(:debug).at_least(:once)

      expect {
        provider.get(uri, { max_attempts: 3, sleep_time: 0 })
      }.to raise_error(BulletProofJson::ProviderError, /Giving up after JSON::ParserError/)
    end
  end

  context "when API key is nil" do
    it "omits Authorization header" do
      no_key_provider = described_class.new(nil, logger)
      expect(Net::HTTP).to receive(:get) do |_, headers|
        expect(headers).not_to include("Authorization")
        "{}"
      end

      result = no_key_provider.get(uri)
      expect(result).to eq({})
    end
  end
end
