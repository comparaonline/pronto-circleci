require "pronto/circleci/version"
require 'pronto/circleci/runner'

module Pronto
  module CircleCI
    module_function

    def run
      Runner.new(pull_requests_urls)
    end

    def pull_requests_urls
      ENV['CI_PULL_REQUESTS'].split(',')
    end

    def gem_root
      return "#{Rails.root}" if defined?(Rails)
      File.expand_path('../../../', __FILE__)
    end
  end
end
