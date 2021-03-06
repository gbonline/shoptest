class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  attr_accessible :quantity, :order_id, :product_id

  scope :valid, where('product_id > 0')
  scope :notvalid, where('product_id = 0')
    
  def comanda
    self.product.name + " qty: "+ self.quantity.to_s #if self.product_id>0
  end
  def cost
    self.product.price.to_d*(self.quantity || 0.0).to_d 
  end
end
