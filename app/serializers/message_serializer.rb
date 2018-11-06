class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :service, :uid
  attributes :sending_status, :sending_error, :send_in, :sent_at
  attributes :params_errors

  def id
    object.id.to_s if object.persisted?
  end

  def send_in
    object.send_in&.to_i
  end

  def sent_at
    object.sent_at&.to_i
  end

 # remove blank attributes
  def serializable_hash(*args)
    super(*args).select { |k, v| v.present? }
  end
end
