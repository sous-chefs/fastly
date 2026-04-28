# frozen_string_literal: true

module FastlyCookbook
  module Helpers
    def auth_hash
      return { username: new_resource.username, password: new_resource.password } if new_resource.username && new_resource.password
      return { api_key: new_resource.api_key } if new_resource.api_key

      raise 'A username and password or api key must be set'
    end

    def fastly_client
      install_fastly_gem
      @fastly_client ||= ::Fastly.new(auth_hash)
    end

    def install_fastly_gem
      return if defined?(::Fastly)

      begin
        require 'fastly'
      rescue LoadError
        chef_gem 'fastly' do
          compile_time true
        end
        require 'fastly'
      end
    end

    def fastly_service
      fastly_client.list_services.find { |svc| svc.name == new_resource.service } || raise('The service does not exist')
    end

    def fastly_service_options
      {
        service_id: fastly_service.id,
        version: fastly_service.version.number,
      }
    end

    def named_fastly_object(list_method, options = fastly_service_options)
      fastly_client.public_send(list_method, options).find { |object| object.name == new_resource.name }
    end

    def create_fastly_object(create_method, options)
      created_object = nil
      converge_by("create #{new_resource}") do
        created_object = fastly_client.public_send(create_method, options)
      end
      created_object
    end

    def update_fastly_property(object, fastly_property, desired_value, resource_property = fastly_property)
      return if object.public_send(fastly_property) == desired_value

      converge_by("update #{new_resource} #{resource_property}") do
        object.public_send("#{fastly_property}=", desired_value)
        object.save!
      end
    end

    def update_fastly_integer_property(object, fastly_property, desired_value, resource_property = fastly_property)
      return if object.public_send(fastly_property).to_i == desired_value

      update_fastly_property(object, fastly_property, desired_value, resource_property)
    end

    def update_fastly_bool_string_property(object, fastly_property, desired_value, resource_property = fastly_property)
      update_fastly_property(object, fastly_property, fastly_bool(desired_value), resource_property)
    end

    def fastly_bool(bool)
      return if bool.nil?

      bool ? '1' : '0'
    end
  end
end
