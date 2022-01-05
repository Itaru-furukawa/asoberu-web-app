class Api::V1::EventsController < ApplicationController
  def index
    events = Event.where(schedule_id: params[:id], password: params[:password])
    if events.present?
      render status: '200', json: { message: 'success', data: events }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  def show
    schedule = Schedule.where(id: params[:id], password: params[:password])
    if schedule.present?
      render status: '200', json: { message: 'success', data: schedule }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  def create
    schedule = Schedule.new(schedule_params)
    schedule.save!
    render status: '200', json: { message: 'success', data: schedule }
  end

  def update
    schedule = Schedule.where(id: params[:id], password: params[:password])
    if schedule.present?
      schedule.update(schedule_params)
      render status: '200', json: { message: 'success', data: schedule }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :member_number, :password, :start_date, :end_date)
  end
end
