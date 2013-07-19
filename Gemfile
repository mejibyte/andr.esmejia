# Edit this Gemfile to bundle your application's dependencies.
# This preamble is the current preamble for Rails 3 apps; edit as needed.
source 'http://rubygems.org'

gem 'rails', '3.1.12'
gem 'mysql2', '~> 0.3.0'

gem 'RedCloth'
gem 'coderay'
source 'http://gems.github.com/'
gem 'augustl-redclothcoderay', :require => 'redclothcoderay'
gem 'authlogic'
gem 'paperclip'
gem 'redcarpet', '~> 2.0.0b5'

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "factory_girl_rails"
end

group :production do
  gem "pg"
end

# I'm lazy and don't want to translate the routes yet.
gem "rails_legacy_mapper"