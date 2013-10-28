class Order < ActiveRecord::Base
  attr_accessible :delivery_address, :line_items_attributes
  
  has_many :line_items
  has_many :products, :through => :line_items
  accepts_nested_attributes_for :line_items , allow_destroy: true , reject_if: proc { |attributes| attributes['product_id']=='0' } 
  
 # after_save :clean_item
  def total
    self.line_items.sum{|item| item.cost}
    #line_items.to_a.sum{|item| item.total_price}
  end
  private
  
  def clean_item
    self.line_items.notvalid.delete_all
  
  end
end
