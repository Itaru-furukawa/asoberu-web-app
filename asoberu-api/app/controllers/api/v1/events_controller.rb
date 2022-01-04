class Api::V1::EventsController < ApplicationController
  def index
    schedules = Schedule.order(created_at: :desc)
    render json: { status: '200', message: 'Loaded schedules', data: schedules }
  end
end
