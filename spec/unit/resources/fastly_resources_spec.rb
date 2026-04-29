# frozen_string_literal: true

require 'spec_helper'

class FastlyObject
  attr_accessor :name, :id, :version, :ip

  def initialize(name = nil)
    @name = name
    @id = 'service-id'
    @version = FastlyObjectVersion.new
    @entries = []
    @attributes = {}
  end

  def list_entries
    @entries
  end

  def create_entry(ip:)
    @entries << FastlyObject.new.tap { |entry| entry.ip = ip }
  end

  def delete_entry(entry)
    @entries.delete(entry)
  end

  def save!
    true
  end

  def purge_all
    true
  end

  def method
    @attributes[:method]
  end

  def method=(value)
    @attributes[:method] = value
  end

  def method_missing(method_name, *args)
    method_string = method_name.to_s

    if method_string.end_with?('=')
      @attributes[method_string.delete_suffix('=').to_sym] = args.first
    else
      @attributes[method_name]
    end
  end

  def respond_to_missing?(_method_name, _include_private = false)
    true
  end
end

class FastlyObjectVersion
  attr_reader :number

  def initialize
    @number = 1
  end

  def activate!
    true
  end

  def clone
    true
  end
end

RSpec.describe 'fastly custom resources' do
  let(:client) { instance_double('FastlyClient') }
  let(:service) { FastlyObject.new('service_name') }
  let(:fastly_resources) do
    %i(
      fastly_acl
      fastly_backend
      fastly_cache_setting
      fastly_condition
      fastly_domain
      fastly_gzip
      fastly_header
      fastly_healthcheck
      fastly_request_setting
      fastly_response
      fastly_s3_logging
      fastly_service
      fastly_syslog_logging
    )
  end

  before do
    stub_const('Fastly', Class.new)
    allow(Fastly).to receive(:new).and_return(client)
    allow(client).to receive(:list_services).and_return([service])

    {
      list_domains: [],
      list_backends: [],
      list_conditions: [],
      list_cache_settings: [],
      list_request_settings: [],
      list_headers: [],
      list_gzips: [],
      list_healthchecks: [],
      list_response_objects: [],
      list_s3_loggings: [],
      list_syslogs: [],
      list_acls: [],
    }.each do |method_name, value|
      allow(client).to receive(method_name).and_return(value)
    end

    {
      create_service: FastlyObject.new('service_name'),
      create_domain: FastlyObject.new('www.example.com'),
      create_backend: FastlyObject.new('backend'),
      create_condition: FastlyObject.new('condition'),
      create_cache_setting: FastlyObject.new('cache'),
      create_request_setting: FastlyObject.new('request'),
      create_header: FastlyObject.new('header'),
      create_gzip: FastlyObject.new('gzip'),
      create_healthcheck: FastlyObject.new('healthcheck'),
      create_response_object: FastlyObject.new('response'),
      create_s3_logging: FastlyObject.new('s3'),
      create_syslog: FastlyObject.new('syslog'),
      create_acl: FastlyObject.new('acl'),
    }.each do |method_name, value|
      allow(client).to receive(method_name).and_return(value)
    end

    allow(client).to receive(:update_backend)
  end

  it 'converges every Fastly custom resource' do
    expect do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04', step_into: fastly_resources).converge('fastly_test::all_resources')
    end.not_to raise_error
  end

  it 'creates missing Fastly API objects' do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '22.04', step_into: fastly_resources).converge('fastly_test::all_resources')

    expect(client).to have_received(:create_service)
    expect(client).to have_received(:create_domain)
    expect(client).to have_received(:create_backend)
    expect(client).to have_received(:create_condition)
    expect(client).to have_received(:create_cache_setting)
    expect(client).to have_received(:create_request_setting)
    expect(client).to have_received(:create_header)
    expect(client).to have_received(:create_gzip)
    expect(client).to have_received(:create_healthcheck)
    expect(client).to have_received(:create_response_object)
    expect(client).to have_received(:create_s3_logging)
    expect(client).to have_received(:create_syslog)
    expect(client).to have_received(:create_acl)
  end
end
