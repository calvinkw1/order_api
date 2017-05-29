class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :customer
end
