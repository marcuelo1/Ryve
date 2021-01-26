class CurrentTransactionSerializer < ActiveModel::Serializer
  attributes :id, :status, :time_remaining, :is_paid, :buyer, :rider, :created_at, :location, :products

  def buyer
    BuyerSerializer.new(object.buyer).attributes
  end

  def rider
    RiderSerializer.new(object.rider).attributes
  end

  def location
    BuyerLocationSerializer.new(object.buyer_location).attributes
  end

  def products
    checkout_order = CheckoutOrder.find(object.checkout_order_id)
    ActiveModel:: SerializableResource.new(
      checkout_order.checkout_products,
      each_serializer: CheckoutProductSerializer
    )
  end
  
  
end
