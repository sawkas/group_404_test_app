class SendMessageJob < ActiveJob::Base
  queue_as :messages

  def perform(message_id)
    message = Message.find(message_id)
    messenger_service = "messengers/#{message.service}".classify.constantize.new
    sending_result = messenger_service.send_message(message)

    case sending_result[:status]
    when :success
      message.update(sent_at: Time.now, sending_status: :success)
    when :error
      message.update(sent_at: Time.now, sending_status: :fail, sending_error: sending_result[:error])
    end
  end
end
