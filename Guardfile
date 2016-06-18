group :red_green_refactor, halt_on_fail: true do
  guard :rspec, cmd: 'bundle exec rspec' do
    watch('spec/spec_helper.rb') { 'spec' }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/.+\.rb$}) { 'spec' }
  end

  guard :rubocop, all_on_start: false, notification: false do
    watch(/.+\.rb$/)
    watch(%r{(?:.+/)?\.rubocop.*?\.yml$}) { |m| File.dirname(m[0]) }
  end
end
