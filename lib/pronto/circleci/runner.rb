require 'pronto/circleci/pull_request'

module Pronto
  module CircleCI
    module Runner
      COMMAND = "PRONTO_GITHUB_ACCESS_TOKEN=#{ENV['GITHUB_ACCESS_TOKEN']} "\
      "PRONTO_PULL_REQUEST_ID=%{pull_request_id} "\
      "bundle exec pronto run -f %{flags} -c origin/%{base_branch}"

      FLAGS_MAP = {
        'comments_on_diff' => 'github_pr',
        'reviews_on_diff' => 'github_pr_review',
        'report_status' => 'github_status'
      }.freeze

      DEFAULT_FLAG = 'github'.freeze

      module_function

      def run(pull_requests_urls)
        pull_requests_urls.each do |pr_url|
          pull_request = PullRequest.load_from_url(pr_url)
          system(cmd(pull_request))
        end
      end

      def cmd(pull_request)
        COMMAND % {
          pull_request_id: pull_request.id,
          base_branch: pull_request.base_branch,
          flags: flags
        }
      end

      def flags
        flag_list = FLAGS_MAP.inject([]) do |memo, (config_key, flag)|
          Config.instance.get('pronto', config_key) ? memo << flag : memo
        end
        flag_list.any? ? flag_list.join(' ') : DEFAULT_FLAG
      end
    end
  end
end
