class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.where(id: params[:id], password: params[:password])
    render json: { status: '200', message: 'Loaded schedules', data: schedules, hoge: params[:password]}
  end

  def show
    schedule = Schedule.where(id: params[:id], password: params[:password])
    if schedule.present?
      render status: '200', json: {message: 'success', data: schedule}
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  def create
    schedule = Schedule.create(schedule_params)
    render status: '200', json: { message: 'success', data: schedule}
  end

  def update
    schedule = Schedule.where(id: params[:id], password: params[:password])
    if schedule.present?
      schedule.update(schedule_params)
      render status: '200', json: { message: 'success', data: schedule}
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :member_number, :password, :start_date, :end_date)
  end
end
