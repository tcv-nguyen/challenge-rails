# Ruby on Rails Challenge

Please complete this challenge in order to be considered for the Ruby on Rails position. This challenge will demonstrate your abilities with the framework, test-driven development, interfacing with APIs, and your knack for solving problems and following directions. This should take no more than 1-2 hours at most to complete.

# Description

We will be creating models that interface with [Stripe's API](https://stripe.com/docs/api). And if you're feeling up to it, there's also a bonus. Alright, let's get started!

# Specifications

Please build out the following requirements below supported by RSpec tests. You will also need to [sign up for a Stripe account](https://dashboard.stripe.com/register) in order to work with their API.

- Create a `Customer` model with various fields such as `email`
- When a `Customer` gets created, a [customer in Stripe](https://stripe.com/docs/api#customers) is also created. The `email` attribute should match the model's `email` field
- When a `Customer` is updated, its object in Stripe is also updated. So that means if the email of a `Customer` is changed, it should also reflect in Stripe
- When a `Customer` is detroyed, its object in Stripe is also destroyed

## Bonus

- A `Customer` can have many `CreditCard` models
- Similar to the `Customer` model, the `CreditCard` model should also be synced with [Stripe's Card object](https://stripe.com/docs/api#cards)
- Implement a `CreditCard#charge!` method that creates a Stripe charge

# Submission

Commit your code and generate a patch with

```
$ git diff --no-prefix master > solution.patch
```

Send the generated patch file to **challenge@funnelthecake.com** with the subject line: **Rails Challenge**. In the body of the email, please explain your thought process and why you chose to solve it the way you did.