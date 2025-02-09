require "bullet_proof_json"
require "pry"

RSpec.describe BulletProofJson do

  before do
    NOMINATIM_OPENSTRETMAP_SEARCH_URL ||= "https://nominatim.openstreetmap.org/search"
    RESTFUL_API_DEV_OBJECTS_URL ||= "https://api.restful-api.dev/objects"
    @json_provider = BulletProofJson::Provider.new

  end

  it "has a version number" do
    expect(BulletProofJson::VERSION).not_to be nil
  end

  describe "real requests" do

    it "fetches some generic response from a sample RESTful API" do

      json = @json_provider.get(RESTFUL_API_DEV_OBJECTS_URL)

      expect(json.size).to eq(13)
      expect(json[0]["id"]).to eq("1")
      expect(json[0]["name"]).to eq("Google Pixel 6 Pro")
      expect(json[0]["data"]["color"]).to eq("Cloudy White")
      expect(json[0]["data"]["capacity"]).to eq("128 GB")
    end

    it "fetches some geolocation response from a OpenStreetMap.org" do

      json = @json_provider.get("#{NOMINATIM_OPENSTRETMAP_SEARCH_URL}?city=WARSZAWA&state=MAZOWIECKIE&country=Poland&format=geocodejson&street=44%20Z%C5%81OTA")

      expect(json["type"]).to                         eq("FeatureCollection")
      expect(json["geocoding"]["version"]).to         eq("0.1.0")
      expect(json["geocoding"]["attribution"]).to     eq("Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright")
      expect(json["geocoding"]["licence"]).to         eq("ODbL")
      expect(json["geocoding"]["query"]).to           eq("44 ZŁOTA, WARSZAWA, MAZOWIECKIE, Poland")
      expect(json["features"].size).to be > 0
    end


    it "fetches some geolocation response from a OpenStreetMap.org with maximum retries of 30 and really long sleep time between attempts" do

      json = @json_provider.get("#{NOMINATIM_OPENSTRETMAP_SEARCH_URL}?city=WARSZAWA&state=MAZOWIECKIE&country=Poland&format=geocodejson&street=44%20Z%C5%81OTA", {sleep_time: 60, max_attempts: 30})

      expect(json["type"]).to                         eq("FeatureCollection")
      expect(json["geocoding"]["version"]).to         eq("0.1.0")
      expect(json["geocoding"]["attribution"]).to     eq("Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright")
      expect(json["geocoding"]["licence"]).to         eq("ODbL")
      expect(json["geocoding"]["query"]).to           eq("44 ZŁOTA, WARSZAWA, MAZOWIECKIE, Poland")
      expect(json["features"].size).to be > 0
    end

    it "fetches some geolocation response from a OpenStreetMap.org with default sleep time between attempts when it is not defined in options properly" do

      json = @json_provider.get("#{NOMINATIM_OPENSTRETMAP_SEARCH_URL}?city=WARSZAWA&state=MAZOWIECKIE&country=Poland&format=geocodejson&street=44%20Z%C5%81OTA", {max_attempts: 1})

      expect(json["type"]).to                         eq("FeatureCollection")
      expect(json["geocoding"]["version"]).to         eq("0.1.0")
      expect(json["geocoding"]["attribution"]).to     eq("Data © OpenStreetMap contributors, ODbL 1.0. http://osm.org/copyright")
      expect(json["geocoding"]["licence"]).to         eq("ODbL")
      expect(json["geocoding"]["query"]).to           eq("44 ZŁOTA, WARSZAWA, MAZOWIECKIE, Poland")
      expect(json["features"].size).to be > 0
    end
  end
end
