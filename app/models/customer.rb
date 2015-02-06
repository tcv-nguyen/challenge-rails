class Customer < ActiveRecord::Base
  include HasStripe

  validates :name, presence: true
  validates :email, presence: true

  has_stripe :stripe_id
end
