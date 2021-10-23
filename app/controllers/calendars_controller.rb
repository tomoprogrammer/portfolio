class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all #where(user_id: current_user.id)
  end
end
