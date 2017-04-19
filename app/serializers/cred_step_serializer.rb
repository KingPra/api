class CredStepSerializer < ActiveModel::Serializer
  attributes :id
  has_one :credit
end
