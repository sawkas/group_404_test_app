module Messengers
  class Base
    def send_message(message)
      recipient_id = message.uid
      text         = message.text

      parsed_result
    end

    private

    def parsed_result
      [
        { status: :success },
        { status: :error, error: :authentication_fail },
        { status: :error, error: :timeout_error }
      ].sample
    end
  end
end
