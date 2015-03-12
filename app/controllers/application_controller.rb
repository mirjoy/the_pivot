class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::TextHelper

  def load_cart
    @cart = Cart.new(session[:cart])
  end
  before_action :load_cart


end
