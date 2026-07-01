# frozen_string_literal: true

name 'fastly'

run_list 'fastly_test::default'

cookbook 'fastly', path: '.'
cookbook 'fastly_test', path: './test/fixtures/cookbooks/fastly_test'

named_run_list :all_resources, 'fastly_test::all_resources'
named_run_list :default, 'fastly_test::default'
named_run_list :service, 'fastly_test::service'
