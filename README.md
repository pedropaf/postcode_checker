# Postcode Checker

This is a Rails 6.1 app that renders a form where the user can input a UK postcode. When submitting the form, the response should
tell the user if the postcode is allowed or not.

After you checkout the solution, run "bundle install" to install the dependencies, and "rails server" to run it locally.

## Code linter

Rubocop rails is installed with default settings, but documentation is disabled, as I'm not generating documentation from comments.
Run bundle exec rubocop -A to fix all autofixable issues, and also see if there are any issues remaining that need fixing. This should run as part of CI, and maybe as a pre-commit hook.

## RSpec tests
The project is using RSpec for unit testing and integration testing. Run "rspec" to run the full test suite, and make sure that everything is still working if you make any changes. Also to verify what's the code coverage, SimpleCov is used, after you run the test suite, execute "open coverage/index.html" to view in your browser a summary.

