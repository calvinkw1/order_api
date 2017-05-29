class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :quantity
  has_one :product
  has_one :order
end
