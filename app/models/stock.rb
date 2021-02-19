class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker ,presence: true

  def self.new_lookup(ticker_symbol) #it is a class method
    client = IEX::Api::Client.new(
       publishable_token: Rails.application.credentials.iex_client[:publishable_token_api_key],
       secret_token: Rails.application.credentials.iex_client[:secret_token_api_key],
       endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol)) #it will be return stock price
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
