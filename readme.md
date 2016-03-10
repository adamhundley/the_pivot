Heroku: https://littleowl.herokuapp.com


## Testing

All testing in Little Owl was done via [RSpec-rails](https://github.com/rspec/rspec-rails).  We used [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers) to test database validations and relationship.  Our coverage was tested using [simplecov](https://github.com/colszowka/simplecov).

### Running tests

Once you have the repo cloned, make sure to reset the database on your local machine and bundle so that you have access to all gems.  

In order to run all tests at once simply enter this into your command line: `rspec`

If you would like to run a specific test enter, the whole path of that test, preceeded by the rspec command: ie. 
```
rspec spec/features/user/user_adds_product_to_cart_spec.rb
```
In order to see coverage for our testing suite simply type the command `open coverage/index.html` and it will show the index page for our simple cov code coverage. 

Happy testing!
