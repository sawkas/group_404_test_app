class MessageParamsValidator
  SCHEMA = Dry::Validation.Schema do
    required(:text).value(:str?, size?: 1..140)
    required(:service).value(included_in?: Message.service.values)
    required(:uid).value(:str?, size?: 1..20)
    optional(:send_in).maybe(:int?, gt?: Time.now.to_i)
  end

  def self.validate(message_params)
    SCHEMA.call(message_params).errors
  end
end
