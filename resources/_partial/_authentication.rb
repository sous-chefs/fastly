# frozen_string_literal: true

property :username, String,
         desired_state: false
property :password, String,
         desired_state: false,
         sensitive: true
property :api_key, String,
         desired_state: false,
         sensitive: true
