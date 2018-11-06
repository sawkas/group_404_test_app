class MessagesController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods # for basic auth in api controller
  http_basic_authenticate_with name: ENV['HTTP_AUTHENTICATION_NAME'], password: ENV['HTTP_AUTHENTICATION_PASSWORD']

  def send_message
    render json: messages_params.map{ |mp| MessageSender.new(mp).send }
  end

  def send_message_immediately
    render json: messages_params.map{ |mp| MessageSender.new(mp).send_immediately }
  end

  def message_info
    render json: Message.find(params[:message_id])
  end

  private

  def messages_params
    common_params = params.permit(:text, :send_in)

    params.permit(recipients: [:service, :uid])[:recipients].map do |message_params|
      message_params.merge(common_params)
    end
  end
end
