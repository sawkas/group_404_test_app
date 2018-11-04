class MessagesController < ActionController::API
  def send_message
    render json: messages_params.map{ |mp| MessageSender.new(mp).send }
  end

  def send_message_immediately
    render json: messages_params.map{ |mp| MessageSender.new(mp).send_immediately }
  end

  def message_info
  end

  private

  def messages_params
    common_params = params.permit(:text, :send_in)

    params.permit(recipients: [:service, :uid])[:recipients].map do |message_params|
      message_params.merge(common_params)
    end
  end
end
