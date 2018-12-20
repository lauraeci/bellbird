class AlarmsController < ApplicationController
  def index
   @alarms = Alarm.left_joins(:votes)
                 .group(:id)
                 .order('COUNT(votes.id) DESC').order(:created_at)
  end

  def new
    @alarm = Alarm.new
  end

  def create
    @alarm = Alarm.new(alarm_params)

    if @alarm.save
      flash[:success] = "Your alarm was created successfully"

      redirect_to alarms_path
    else
      render :new
    end
  end

  private

  def alarm_params
    params.require(:alarm).permit(:text)
  end
end
