class CredTransactionSerializer < ActiveModel::Serializer
  attributes :id, :delta, :delta_type, :created_at, :action

  def delta_type
    object.delta.positive? ? "positive" : "negative"
  end

  def action
    object.event&.category
  end
end
