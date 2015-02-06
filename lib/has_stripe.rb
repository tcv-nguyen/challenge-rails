class Card
  attr_accessor :id, :number, :exp_month, :exp_year

  def initialize(options)
    @id, @number, @exp_month, @exp_year = options[:id], options[:number], options[:exp_month], options[:exp_year]
  end
end

module HasStripe
  extend ActiveSupport::Concern

  module ClassMethods
    def has_stripe(stripe_column)
      raise "There is no column name #{stripe_column} in table #{table_name}" unless column_names.include?(stripe_column.to_s)
      metaclass = class << self; self; end
      metaclass.instance_eval do
        define_method(:stripe_column) { stripe_column }
      end
    end
  end

  def get_stripe_account(force_create = true)
    begin
      @stripe_account = Stripe::Customer.retrieve(get_stripe_id)
    rescue Stripe::InvalidRequestError => e
      if force_create
        @stripe_account = create_stripe_account
      else
        puts "There is no Stripe account under stripe_column: #{get_stripe_id}"
      end
    end
    @stripe_account
  end

  def add_card(card_token)
    get_stripe_account.cards.create(card: card_token)
  end

  # options = {:card_id, :number}
  # TODO: Need details on how to update the cards, tokens...
  def update_card(options = {})
    card_id = options.delete(:card_id)
    card = get_stripe_account.cards.retrieve(card_id)
    options.each do |key, value|
      card.send("#{key}=", value)
    end
    card.save
  end

  def remove_card(card_id)
    get_stripe_account.cards.retrieve(card_id).delete
  end

  # options = { :amount, :currency, :card_id, :description, :card_details(Card Object) }
  def charge_card(options = {})
    amount = options[:amount].to_f
    currency = options[:currency].presence || "usd"
    card_id = options[:card_id]
    description = options[:description]

    # Ensure the card belong to the Customer
    begin
      card = get_stripe_account.cards.retrieve(card_id)
      @charge = 
        Stripe::Charge.create(
          amount: amount,
          currency: currency,
          customer: get_stripe_id,
          card: card_id,
          description: description
        )
    rescue Exception => e
      puts "Customer #{name} do not own this card"
    end
    @charge
  end

  private
    def stripe_column
      self.class.stripe_column
    end

    def get_stripe_id
      send(stripe_column)
    end

    def build_card(card_options)
      Card.new(card_options)
    end

    def create_stripe_account(card = nil)
      # TODO: Should not create new Stripe account if the Object is not valid yet.
      stripe_account = Stripe::Customer.create({
          card: card,
          email: email,
          description: "Stripe Account of #{name}"
        })
      self.send("#{stripe_column}=", stripe_account.id)
      stripe_account
    end
end
