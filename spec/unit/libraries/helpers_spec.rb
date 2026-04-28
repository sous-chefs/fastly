# frozen_string_literal: true

require 'spec_helper'
require 'libraries/helpers'

RSpec.describe FastlyCookbook::Helpers do
  subject(:helper) do
    Class.new do
      include FastlyCookbook::Helpers
      attr_accessor :new_resource
    end.new
  end

  let(:resource) { double('resource', username: nil, password: nil, api_key: nil) }

  before do
    helper.new_resource = resource
  end

  describe '#auth_hash' do
    it 'uses username and password when both are set' do
      allow(resource).to receive(:username).and_return('user')
      allow(resource).to receive(:password).and_return('pass')

      expect(helper.auth_hash).to eq(username: 'user', password: 'pass')
    end

    it 'uses api_key when username and password are not set' do
      allow(resource).to receive(:api_key).and_return('key')

      expect(helper.auth_hash).to eq(api_key: 'key')
    end

    it 'raises when no credentials are set' do
      expect { helper.auth_hash }.to raise_error(RuntimeError, 'A username and password or api key must be set')
    end
  end

  describe '#fastly_bool' do
    it 'converts booleans to Fastly string values' do
      expect(helper.fastly_bool(true)).to eq('1')
      expect(helper.fastly_bool(false)).to eq('0')
      expect(helper.fastly_bool(nil)).to be_nil
    end
  end
end
