guard :rspec, cmd: 'rspec' do
  # watch(%r{^libraries/(.+)\.rb$})
  # watch(%r{^libraries/(.+)\.rb$}) { |match| "spec/unit/#{match[1]}_spec.rb" }
  watch(%r{^libraries/(.+)\.rb$}) { 'spec' }
  watch(%r{^spec/unit/.+_spec\.rb$})
  watch(%r{^recipes/(.+)\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
end

