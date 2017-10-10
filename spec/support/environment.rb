require_relative 'github_mock'

ENV['PRONTO_GITHUB_ACCESS_TOKEN'] = GithubMock.access_token
ENV['CI_PULL_REQUESTS'] = GithubMock.pull_requests_urls.join(',')
