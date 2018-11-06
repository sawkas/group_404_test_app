class Message
  include Mongoid::Document
  extend Enumerize

  attr_accessor :params_errors

  field :text,           type: String
  field :service,        type: String
  field :uid,            type: String
  field :send_in,        type: DateTime
  field :sent_at,        type: DateTime
  field :sending_status, type: String
  field :sending_error,  type: String

  enumerize :service, in: %i[telegramm viber whatsapp]
  enumerize :sending_status, in: %i[in_queue scheduled success fail]
end
