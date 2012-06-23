# A sample Guardfile
# More info at https://github.com/guard/guard#readme
ENV['NETATLAS_ENVIRONMENT'] = 'test'
#guard 'ctags-bundler' do
#  watch(%r{^(lib)/.*\.rb$})  { ["lib"] }
#  watch('Gemfile.lock')
#end

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

