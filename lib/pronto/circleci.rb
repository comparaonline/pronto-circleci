require 'pronto/circleci/version'
require 'pronto/circleci/runner'

module Pronto
  module CircleCI
    module_function

    def run
      Runner.run(pull_requests_urls)
    end

    def pull_requests_urls
      return ENV['CI_PULL_REQUESTS'].split(',') if ENV.key?('CI_PULL_REQUESTS')
      return []
    end

    def gem_root
      Dir.pwd
    end
  end
end
