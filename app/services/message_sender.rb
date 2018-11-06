class MessageSender
  attr_reader :message

  def initialize(params)
    @message = Message.new(params)
    @message.params_errors = MessageParamsValidator.validate(params)
    @message.save if message.params_errors.blank?
  end

  def send
    return message unless message.persisted?

    if message.send_in
      message.update(sending_status: :scheduled)
      SendMessageJob.set(wait_until: message.send_in).perform_later(message.id.to_s)
    else
      message.update(sending_status: :in_queue)
      SendMessageJob.perform_later(message.id.to_s)
    end

    message
  end

  def send_immediately
    return message unless message.persisted?
    SendMessageJob.perform_now(message.id.to_s)
    message.reload
  end
end
