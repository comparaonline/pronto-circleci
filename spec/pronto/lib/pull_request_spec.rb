require 'spec_helper'

RSpec.describe Pronto::CircleCI::PullRequest do
  let(:pull_request_id) { GithubMock.pull_request_id }

  before(:example) do
    GithubMock.pull_request_api(pull_request_id)
    pull_request_url = GithubMock.pull_request_url(pull_request_id)
    @pull_request = described_class.load_from_url(pull_request_url)
  end

  it 'loads the pull request base branch' do
    expect(@pull_request.base_branch).to eq('master')
  end

  it 'stores the pull request id' do
    expect(@pull_request.id).to eq(pull_request_id)
  end
end
