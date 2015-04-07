guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/unit/.+_spec\.rb$})
  watch(%r{^libraries/(.+)\.rb$})
  watch(%r{^recipes/(.+)\.rb$})
  watch('spec/spec_helper.rb')  { "spec" }
end
