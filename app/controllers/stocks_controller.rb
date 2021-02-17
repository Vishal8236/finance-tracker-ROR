class StocksController < ApplicationController
  def search
    # byebug
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        render 'users/my_portfolio'
      else
        flash[:alert] = "please enter a valid symbole to search"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = "please enter a symbole to search"
      redirect_to my_portfolio_path
    end
  end
end
