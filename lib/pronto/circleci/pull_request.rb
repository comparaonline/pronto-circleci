require "pronto/circleci/config"
require 'json'
require 'open-uri'

module Pronto
  module CircleCI
    class PullRequest
      GITHUB_API_URL = "https://api.github.com/repos/%{org}/%{repo}/pulls/"\
        "%{pull_request_id}?access_token=#{ENV['GITHUB_ACCESS_TOKEN']}"

      attr_reader :id, :base_branch

      class << self
        def load_from_url(url)
          id = id_from_url(url).to_i
          api_url = GITHUB_API_URL % {
            org: Config.instance.get('github', 'org'),
            repo: Config.instance.get('github', 'repo'),
            pull_request_id: id
          }
          # byebug

          response = JSON.load(open(api_url))
          new(id, extract_base_branch(response))
        end

        def id_from_url(url)
          url.split('/').last
        end

        def extract_base_branch(response)
          response.dig('base', 'ref')
        end
      end

      private

      def initialize(id, base_branch)
        @id = id
        @base_branch = base_branch
      end
    end
  end
end
