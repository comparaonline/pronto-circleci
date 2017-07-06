require 'webmock'
include WebMock::API
WebMock.enable!

module GithubMock
  ORG = 'comparaonline'.freeze
  REPO = 'pronto-circleci'.freeze
  ACCESS_TOKEN = 'dummy'.freeze
  DEFAULT_BRANCH = 'master'.freeze
  PULL_REQUESTS_IDS = [10, 20, 5].freeze
  PULL_REQUEST_URL = "https://github.com/#{ORG}/#{REPO}/pulls/%{id}".freeze

  module_function

  def pull_request_api(pull_request_id)
    api_url = format(
      Pronto::CircleCI::PullRequest::GITHUB_API_URL,
      org: ORG,
      repo: REPO,
      pull_request_id: pull_request_id
    )

    response = { 'base' => { 'ref' => DEFAULT_BRANCH } }
    stub_request(:get, api_url).to_return(status: 200, body: response.to_json)
  end

  def pull_request_apis
    PULL_REQUESTS_IDS.each { |pr_id| pull_request_api(pr_id) }
  end

  def pull_request_id
    PULL_REQUESTS_IDS.sample
  end

  def pull_request_url(pull_request_id = PULL_REQUESTS_IDS.sample)
    format(PULL_REQUEST_URL, id: pull_request_id)
  end

  def pull_requests_urls
    PULL_REQUESTS_IDS.map { |pr_id| pull_request_url(pr_id) }
  end

  def access_token
    ACCESS_TOKEN
  end
end
