class CheckoutProductSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :product_price, :product_discount, :quantity

  def product_name
    object.product.name
  end

  def product_price
    object.product.price
  end

  def product_discount
    object.product.discount
  end
  
end
