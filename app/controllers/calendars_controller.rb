class CalendarsController < ApplicationController
  before_action :authenticate_user!
  def index
    @calendars = Calendar.where(user_id: current_user.id)
  end
end
