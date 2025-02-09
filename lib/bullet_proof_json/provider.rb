require "net/http"
require "json"

module BulletProofJson
  class Provider

    DEFAULT_MAX_ATTEMPTS = 3
    DEFAULT_SLEEP_TIME = 1

    def initialize(api_key=nil, logger=ConsoleLogger.new)
      @api_key = api_key
      @logger = logger
    end

    def get(uri_string = "", options = {max_attempts: 3, sleep_time: 1}, page = nil)
      json = nil

      sleep_time    = options[:sleep_time] || DEFAULT_SLEEP_TIME
      max_attempts  = options[:max_attempts] || DEFAULT_MAX_ATTEMPTS

      begin
        attempts ||= 1
        uri = URI(uri_string)
        http_headers = {}
        http_headers["Authorization"] = "Bearer #{@api_key}" unless @api_key.nil?
        response = ::Net::HTTP.get(uri, http_headers)
        json = JSON(response)

      rescue ::Net::ReadTimeout => e
        @logger.error(self.class.name, " #{page.nil? ? "" : (page.to_s + ":")} #{e}\n#{uri_string}")
        if (attempts += 1) < max_attempts
          @logger.debug(self.class.name, "\tAttempt no. #{attempts} ...")
          sleep sleep_time
          retry
        else
          @logger.error(self.class.name, "\tGiving up!!!")
          raise ProviderError.new("Giving up after Net::ReatTimeout and #{attempts} attempts!")
        end

      rescue ::Net::OpenTimeout => e
        @logger.error(self.class.name, " #{page.nil? ? "" : (page.to_s + ":")} #{e}\n#{uri_string}")
        if (attempts += 1) < max_attempts
          @logger.debug(self.class.name, "\tAttempt no. #{attempts} ...")
          sleep sleep_time
          retry
        else
          @logger.error(self.class.name,  "\tGiving up!!!")
          raise ProviderError.new("Giving up after Net::OpenTimeout and #{attempts} attempts!")
        end

      rescue ::JSON::ParserError => e
        @logger.error(self.class.name, " #{page.nil? ? "" : (page.to_s + ":")} #{e}\n#{uri_string}")

        if (attempts += 1) < max_attempts
          @logger.debug(self.class.name,  "\tAttempt no. #{attempts} ...")
          sleep sleep_time
          retry
        else
          @logger.error(self.class.name, "\tGiving up!!!")
          raise ProviderError.new("Giving up after JSON::ParserError and #{attempts} attempts!")
        end
      end
      json
    end

  end

  class ProviderError < ::StandardError
  end
end