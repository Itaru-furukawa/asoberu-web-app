class Api::V1::MembersController < ApplicationController
  def index
    schedule = Schedule.where(id: params[:schedule_id], password: params[:password]).first
    if schedule.present?
      members = schedule.members
      render status: '200', json: { message: 'success', data: members }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end
  
  def create
    members = Member.create(members_params)
    render status: '200', json: { message: 'success', data: members }
  end

  def update
    schedule = Schedule.where(id: params[:id], password: params[:password]).first
    if schedule.present?
      members = members_params
      members.each do |member| 
        mem = Member.find(member[:id])
        mem.update(member)
      end
      render status: '200', json: { message: 'success' }
    else
      render status: '404', json: { message: 'bad request'}
    end
  end

  private

  def members_params
    params.require(:members).map do |member|
      member.permit(:id, :name, :schedule_id)
    end
  end
end
