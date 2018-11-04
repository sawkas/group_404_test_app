class MessageSender
  attr_reader :message

  def initialize(params)
    @message = Message.new(params)
  end

  def send
    message
  end

  def send_immediately
    message
  end
end
