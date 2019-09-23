class Everybodys::Base < ApplicationController
  layout 'layouts/everybodys/everybodys'
  before_action :login_required
end