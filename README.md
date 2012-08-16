# RetryAnything

Description and usage:

    require 'retry_anything'

    RetryAnything.perform(RuntimeError, :retries => 2, lambda { Logger.error 'Failed' }) do
      # Do something that fails intermittently
    end

# Bundle

    gem 'retry_anything', :git => 'git@github.com:carwoo/retry_anything.git'

# Installing from source

    gem build retry_anything.gemspec
    gem install retry_anything-0.0.1.gem

# Running the tests

Install the rspec gem

    bundle

Run the spec

    rspec spec/retry_anything_spec.rb

Or automatically run the tests when any file changes

    bundle exec guard
