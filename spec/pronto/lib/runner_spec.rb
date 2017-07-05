require 'spec_helper'

RSpec.describe Pronto::CircleCI::Runner do
  def mock_flags(flags, value)
    flags.each do |flag|
      allow(Pronto::CircleCI::Config.instance)
      .to receive(:get)
      .with('pronto', flag)
      .and_return value
    end
  end

  def mock_default_config
    allow(Pronto::CircleCI::Config.instance)
      .to receive(:get)
      .and_wrap_original do |method, *args|
        case args
        when ['config', 'org'] then GithubMock.ORG
        when ['config', 'repo'] then GithubMock.REPO
        else method.call(*args)
        end
      end
  end

  def command_with_flags(pull_request, flags_line)
    cmd = Pronto::CircleCI::Runner::COMMAND % {
      pull_request_id: pull_request.id,
      flags: flags_line,
      base_branch: pull_request.base_branch
    }
  end

  before(:context) do
    GithubMock.pull_request_apis
  end

  before(:example) do
    mock_default_config
  end

  describe '#command_line' do
    before(:example) do
      mock_flags(%w(comments_on_diff reviews_on_diff report_status), false)
    end

    context 'with all pronto config in false' do
      let(:pull_request) {
        pr_url = GithubMock.pull_request_url
        Pronto::CircleCI::PullRequest.load_from_url(pr_url)
      }

      it 'only sets default flag' do
        cmd = command_with_flags(pull_request, 'github')
        expect(described_class.cmd(pull_request)).to eq(cmd)
      end

      it 'set a specific flag' do
        mock_flags(%w(reviews_on_diff), true)
        cmd = command_with_flags(pull_request, 'github_pr_review')
        expect(described_class.cmd(pull_request)).to eq(cmd)
      end

      it 'sets two flags' do
        mock_flags(%w(comments_on_diff reviews_on_diff), true)
        cmd = command_with_flags(pull_request, 'github_pr github_pr_review')
        expect(described_class.cmd(pull_request)).to eq(cmd)
      end
    end
  end
end
