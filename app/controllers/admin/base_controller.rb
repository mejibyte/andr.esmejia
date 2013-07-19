class Admin::BaseController < ApplicationController
  layout "admin"
  before_filter :require_user
  
  #ActiveScaffold.set_defaults do |config| 
  #  config.ignore_columns.add [:created_at, :updated_at]
  #end
end
