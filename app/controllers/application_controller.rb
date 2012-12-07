class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_order
  
 private
  def token
    cookies[:token] ? cookies[:token] : rand(2468**10).to_s(32)
  end
  
  def current_order
    cookies[:token] = { value: token, expires: 1.hour.from_now }
    @current_order ||= Order.where(token: token, state: 'cart').includes(items: [:product]).first || Order.create!(token: token)
  end
end
