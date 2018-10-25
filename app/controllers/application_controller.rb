class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def create
    alert_params = JSON.parse(request.body.read)
    alerts_create = UseCase::Alerts::Create.new(create_params: alert_params)
    alerts_create.call
    head 201, content_type: 'text/html'
  rescue Exception => ex
    render json: {staus: 400, message: "Reference Id is already taken"}, status: 400 and return if ex.message.include? "PG::UniqueViolation: ERROR" 
    render json: {staus: 400, message: "#{ex.message}"}, status: 400
  end

  def list
    alerts = UseCase::Alerts::List.new.call
    render json: alerts
  end

  def update
    UseCase::Alerts::UpdateStatus.new(alert_id: params[:reference_id]).call
    head 204, content_type: 'text/html'
  rescue Exception => ex
    render json: {staus: 400, message: "Alert with Reference Id is not found"}, status: 400 and return if ex.message.include? "Record not found" 
    render json: {staus: 400, message: "#{ex.message} #{ex.backtrace}"}, status: 400
  end
end
