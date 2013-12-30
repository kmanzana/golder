guard :bundler do
  watch('Gemfile')
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})      { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')   { 'spec' }
  watch('golder_app.rb')         { 'spec' }
  watch(%r{^views/.+\.slim$})    { 'spec/app_spec.rb' }
  watch(%r{^config/.+$})         { 'spec' }
  watch(%r{^resources/.+\.yml$}) { 'spec/bwon_output_spec.rb' }
end

guard 'spork' do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch('golder_app.rb')
end
