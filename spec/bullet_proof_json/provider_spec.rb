require "spec_helper"
require "pry"

RSpec.describe BulletProofJson::Provider do

  before do
    NOMINATIM_OPENSTRETMAP_SEARCH_URL ||= "https://nominatim.openstreetmap.org/search"
    RESTFUL_API_DEV_OBJECTS_URL ||= "https://api.restful-api.dev/objects"
    @json_provider = BulletProofJson::Provider.new

  end

  it "has a version number" do
    expect(BulletProofJson::VERSION).not_to be nil
  end

  describe "#user_agent" do
    it "generates proper user_agent for Net::HTTP.get" do
      _project_group = "grzegorzblaszczyk"
      _project_name = "bullet-proof-json"

      expect(@json_provider.send(:user_agent)).to eq "#{_project_name} #{BulletProofJson::VERSION} - https://github.com/#{_project_group}/#{_project_name}"
    end
  end

end
