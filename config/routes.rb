Rails.application.routes.draw do
  post 'send',             action: :send_message,             controller: :messages
  post 'send_immediately', action: :send_message_immediately, controller: :messages
  get  'info/:message_id', action: :message_info,             controller: :messages
end
