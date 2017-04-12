class CreditSerializer < ActiveModel::Serializer
  attributes :id, :name, :points, :title, :description
end
