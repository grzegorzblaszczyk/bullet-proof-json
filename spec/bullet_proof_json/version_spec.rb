require "spec_helper"
require "bullet_proof_json/version"

RSpec.describe BulletProofJson do
  it "has some version number" do
    expect(BulletProofJson::VERSION).not_to be nil
  end
end
