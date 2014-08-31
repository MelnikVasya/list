class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  after_filter :prepare_unobtrusive_flash
end
