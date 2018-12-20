class VotesController < ApplicationController
  def new
    @alarm = Alarm.find params[:alarm_id]

    if @alarm.votes.create
      flash[:success] = "Your vote was entered"

      redirect_to alarms_path
    else
      flash[:error] = "We're sorry something went wrong and your vote wasn't accepted"
      redirect_to alarms_path
    end
  end
end
