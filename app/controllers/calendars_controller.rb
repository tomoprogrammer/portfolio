class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.where(user_id: current_user.id)
  end
end
