require 'spec_helper'

RSpec.describe Pronto::CircleCI do
  it 'has a version number' do
    expect(Pronto::CircleCI::VERSION).not_to be nil
  end

  describe '#pull_requests_urls' do
    it 'parse env variable to an array of url strings' do
      expect(described_class.pull_requests_urls).to eq(
        GithubMock.pull_requests_urls
      )
    end
  end

  describe '#gem_root' do
    context 'on a rails app' do
      let(:path) { 'rails' }
      before(:example) do
        stub_const('Rails', Class.new)
        allow(Rails).to receive('root') { path }
      end

      it 'returns rails folder' do
        expect(described_class.gem_root).to eq(path)
      end
    end

    context 'outside a rails app' do
      let(:path) { File.expand_path('../../../', __FILE__) }

      it 'returns the root of the app' do
        expect(described_class.gem_root).to eq(path)
      end
    end
  end
end
