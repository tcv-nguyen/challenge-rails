require 'rails_helper'
require 'stripe_mock'

RSpec.describe Customer, :type => :model do
  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:customer)      { FactoryGirl.create(:customer) }

  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#add_card" do
    it "creates Stripe customer if none exist" do
      card = customer.add_card(stripe_helper.generate_card_token)

      expect(card.customer).to eq(customer.stripe_id)
    end
  end

  describe "#update_card" do
    it "updates Stripe card number" do
      new_number = "1111111111111111"
      old_card = customer.add_card(stripe_helper.generate_card_token)

      customer.update_card(card_id: old_card.id, number: new_number)

      new_card = customer.get_stripe_account.cards.retrieve(old_card.id)

      expect(new_card.number).to eq(new_number)
    end
  end

  describe "#remove_card" do
    it "removes Customer card" do
      card = customer.add_card(stripe_helper.generate_card_token)

      expect(customer.get_stripe_account.cards.data.count).to eq(1)

      customer.remove_card(card.id)

      expect(customer.get_stripe_account.cards.data.count).to eq(0)
    end
  end

  describe "#charge_card" do
    before do
      @owned_card = customer.add_card(stripe_helper.generate_card_token)

      new_customer = FactoryGirl.create(:customer)
      @new_card = new_customer.add_card(stripe_helper.generate_card_token)
    end

    it "charges Customer if the Customer has card" do
      charge = customer.charge_card(amount: 2, card_id: @owned_card.id)

      expect(charge.amount).to eq(2)
      expect(charge.currency).to eq("usd")
    end

    it "does not charge Customer if the Customer does not own that card" do
      charge = customer.charge_card(amount: 2, card_id: @new_card.id)

      expect(charge).to be_nil
    end
  end
end
