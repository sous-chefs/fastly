#
# Author:: Christopher Webber (<cwebber@chef.io>)
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class FastlyS3Logging < Chef::Resource::FastlyBase

      self.resource_name = :fastly_s3_logging
      actions :create
      default_action :create

      attribute :response_condition, kind_of: String, default: ""
      attribute :bucket, kind_of: String, default: nil
      attribute :access_key, kind_of: String, default: nil
      attribute :secret_key, kind_of: String, default: nil
      attribute :path, kind_of: String, default: nil
      attribute :format, kind_of: String, default: nil
      attribute :period, kind_of: Integer, default: 3600
      attribute :gzip_level, kind_of: Integer, default: 3
    end
  end
end
