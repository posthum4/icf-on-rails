source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.0.1'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'simple_form'
gem 'slim-rails'

# Added by Roland
gem 'figaro'
gem 'restforce'
gem 'jiralicious'
gem 'annotate', ">=2.6.0"

group :development do
  gem 'better_errors'
  #gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'binding_of_caller'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'pry-rails', :group => :development
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'thin'
end
group :production do
  gem 'unicorn'
end
group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require=>false
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'launchy'
  gem 'fuubar'
end
