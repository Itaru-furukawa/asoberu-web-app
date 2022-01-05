class Api::V1::EventsController < ApplicationController
  def index
    schedule = Schedule.where(id: params[:schedule_id], password: params[:password]).first
    if schedule.present?
      events = schedule.events
      render status: '200', json: { message: 'success', data: events }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  def show
    schedule = Schedule.where(id: params[:id], password: params[:password]).first
    if schedule.present?
      events = schedule.events.where(member_id: params[:member_id])
      render status: '200', json: { message: 'success', data: events }
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
    schedule = Schedule.where(id: params[:id], password: params[:password]).first
    if schedule.present?
      events = events_params
      events.each do |event| 
        if event[:id].present?
          ev = Event.find(event[:id])
          ev.update(event)
        else
          Event.create(event)
        end
      end
      render status: '200', json: { message: 'success' }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  private

  def events_params
    params.require(:events).map do |event|
      event.permit(:id, :name, :schedule_id, :member_id, :start, :timed, :color)
    end
  end
end
