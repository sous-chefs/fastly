#
# Cookbook Name:: fastly
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'fastly::default' do

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge(described_recipe)
  end

  it 'installs the fastly gem in the compile phase' do
    expect(chef_run).to install_chef_gem('fastly')
  end

  it 'converges successfully' do
    chef_run # This should not raise an error
  end

end
