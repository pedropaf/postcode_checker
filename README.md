# Postcode Checker

This is a Rails 6.1 app that renders a form where the user can input a UK postcode. When submitting the form, the response should
tell the user if the postcode is allowed or not.

## Code linter

Rubocop rails is installed with default settings, but documentation is disabled, as I'm not generating documentation from comments.
Run bundle exec rubocop -A to fix all autofixable issues, and also see if there are any issues remaining that need fixing. This should run as part of CI, and maybe as a pre-commit hook.