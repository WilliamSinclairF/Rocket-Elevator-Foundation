class QuotesController < ApplicationController
  def user_quotes
    @quotes = Quote.where(user_id: current_user.id)
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.user_id = current_user ? (current_user.id) : (nil)
    @quote.save

    respond_to do |format|
        if @quote.save && user_signed_in?
          format.html do
            redirect_to my_quotes_path, notice: 'Quote created successfully!'
          end
          create_zd_ticket(@quote, 'task')
        elsif @quote.save && !user_signed_in?
          format.html do
            redirect_to root_path, notice: 'Quote created successfully!'
          end
          create_zd_ticket(@quote, 'task')
        else
          format.html { render :new }
        end
      end
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(
      :apartments,
      :floors,
      :basements,
      :businesses,
      :elevator_shafts,
      :parking_spaces,
      :occupants,
      :opening_hours,
      :product_line,
      :install_fee,
      :total_price,
      :unit_price,
      :elevator_number,
      :building_type,
      :user_id,
      :full_name,
      :phone,
      :email
    )
  end
end
