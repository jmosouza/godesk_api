source 'https://rubygems.org'

ruby '~> 2.3.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Secrets
  gem 'dotenv-rails' # set env vars from .env

  # Tests
  gem 'rspec-rails', '~> 3.5' # specs
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Models
  gem 'annotate' # schema comments on models

  # Mailer
  gem 'letter_opener' # pop emails in the browser
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Auth
#
# TODO Identify mysterious knock gem issue.
#
# Knock was throwing an error. I switched to git source and the error is gone.
# Yet I have not identified the difference between rubygems and git sources.
#
# The error:
#   #<NameError: uninitialized constant V1::User>
# in
#   V1::UserTokenController
#
# Clearly it was trying to use a namespaced model that doesn't exist.
# But why does it work using the git source? They seem identical.
gem 'knock', github: 'nsarno/knock' # jwt authentication
gem 'cancancan' # user authorization

# Controllers
gem 'kaminari' # pagination
gem 'prawn'    # pdf generation

# Models
gem 'activerecord-import'     # one-query sql insert
gem 'acts_as_api', '~> 1.0.0' # api response rendering
