class CredStepSerializer < ActiveModel::Serializer
  attributes :id, :body, :title, :state, :labels

  def body
    object.credit&.description
  end

  def title
    object.credit&.title
  end

  def state
    object.status
  end

  def labels
    object.respond_to?(:labels) ? object.labels : []
  end
end
