class MessageSender
  attr_reader :message

  def initialize(params)
    @message = Message.new(params)
    @message.params_errors = MessageParamsValidator.validate(params)
    @message.save if message.params_errors.blank?
  end

  def send
    return message unless message.persisted?
    message
  end

  def send_immediately
    return message unless message.persisted?
    message
  end
end
