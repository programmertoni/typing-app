source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails',              '~> 5.0.1'
gem 'pg'
gem 'puma',               '~> 3.0'
gem 'sass-rails',         '~> 5.0'
gem 'uglifier',           '>= 1.3.0'
gem 'slim',               '3.0'
gem 'bootstrap',          '~> 4.0.0.alpha6'
gem 'vuejs-rails',        '~> 2.1'
gem 'font-awesome-sass',  '~> 4.3'
gem 'bcrypt',             '~> 3.1'
gem 'jquery-rails',       '~> 4.1'
gem 'jbuilder',           '~> 2.5'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3' # this gem is used by bootstrap for tooltips
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
