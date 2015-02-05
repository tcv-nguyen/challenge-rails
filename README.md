# Ruby on Rails Challenge

Please complete this challenge in order to be considered for the Ruby on Rails position. This challenge will demonstrate your abilities with the framework, test-driven development, interfacing with APIs, and your knack for solving problems and following directions. This should take no more than 1-2 hours at most to complete.

# Description

We will be creating models that interface with [Stripe's API](https://stripe.com/docs/api). A [Stripe account](https://dashboard.stripe.com/register) is required in order to work with their API (it's free). Alright, let's get started!

# Problem

We currently have a `Customer` model that needs to have payment support added to it using Stripe. There needs to be the ability to 

- Add a credit card to a `Customer`
- Update the `Customer`'s credit card if it changes
- Remove the `Customer`'s credit card
- Charge a `Customer`'s credit card 

Please have RSpec tests written to support your solution. You are not required to write any views or controllers.

# Submission

Commit your solution and generate a patch file with

```
$ git diff --no-prefix master > solution.patch
```

Then submit your response using [this form](https://docs.google.com/forms/d/1WpRc92w5a-w-FilNy-bPJWw6lTS5FHs33OkxEsPtso0/viewform). Thanks!
