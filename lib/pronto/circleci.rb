require 'pronto/circleci/version'
require 'pronto/circleci/runner'

module Pronto
  module CircleCI
    module_function

    def run
      Runner.run(pull_requests_urls)
    end

    def pull_requests_urls
      ENV['CI_PULL_REQUESTS'].split(',')
    end

    def gem_root
      File.expand_path('config', Dir.pwd)
    end
  end
end
