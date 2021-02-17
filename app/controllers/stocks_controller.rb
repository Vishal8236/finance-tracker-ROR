class StocksController < ApplicationController
  def search
    # byebug
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js {render partial: 'users/result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "please enter a valid symbole to search.."
          format.js {render partial: 'users/result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "please enter a symbole to search.."
        format.js {render partial: 'users/result'}
      end
    end
  end
end
