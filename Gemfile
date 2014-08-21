source 'http://rubygems.org'

gem 'rails', '3.2.15'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  #gem 'coffee-rails', '~> 3.2.1' # comment it if use js instead of coffee

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'
#gem "bcrypt-ruby", :require => "bcrypt"  # Using bcrypt-ruby (3.1.2)


# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'


gem "nested_form"

gem 'kaminari'

gem 'sunspot_rails'
gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development, run using:  rake sunspot:solr:run

gem 'whenever', :require => false


gem 'activemerchant'
gem 'activemerchant_patch_for_china'



group :development do
  gem 'meta_request','0.2.8'
  gem 'progress_bar' # for fulltext index progress reporting, when use rake sunspot:reindex
end
