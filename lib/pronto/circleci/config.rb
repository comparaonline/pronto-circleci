require 'yaml'
require 'singleton'

module Pronto
  module CircleCI
    class Config
      include ::Singleton

      CONFIG_FILE_NAME = 'pronto-circleci.yml'.freeze
      CONFIG_FOLDER = 'config'.freeze

      def initialize
        file_path = File.join(
          CircleCI.gem_root,
          CONFIG_FOLDER,
          CONFIG_FILE_NAME
        )
        @values = YAML.load_file(file_path)
      end

      def get(*keys)
        @values.dig(*keys)
      end
    end
  end
end
