# SpreeMailchimpEcommerce
[![Build Status](https://travis-ci.org/spark-solutions/spree_ecommerce_mailchimp.svg?branch=master)](https://travis-ci.org/spark-solutions/spree_ecommerce_mailchimp)
[![Maintainability](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/maintainability)](https://codeclimate.com/github/spark-solutions/spree_ecommerce_mailchimp/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f78be32523b539f2788/test_coverage)](https://codeclimate.com/github/spark-solutions/spree_ecommerce_mailchimp/test_coverage)


## Installation
1. Add this line to your application's Gemfile:

```ruby
gem 'spree_mailchimp_ecommerce', github: 'spark-solutions/spree_ecommerce_mailchimp', branch: 'master'
```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Install extension
  ```bash
  $ bundle exec rails g spree_mailchimp_ecommerce:install
  ```

4. Review your keys in `config/initializers/spree_mailchimp_ecommerce.rb`

5. Restart your server

## User first and last name

By default, Spree doesn't provide `firstname` and `lastname` methods for the User model. However, MailChimp requires this fields. `SpreeMailchimpEcommerce` define these methods in presenter as

```ruby
  def firstname
    user.try(:firstname) || user&.bill_address&.firstname || "unknown firstname"
  end

  def lastname
    user.try(:lastname) || user&.bill_address&.lastname || "unknown lastname"
  end
```

Feel free to define `firstname` and `lastname` in your `User` model decorator.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
