class Order < ActiveRecord::Base
  attr_accessible :buyer_id, :create_time, :deadline, :deal_date, :deal_price, :price, :price_type, 
          :vendor_id, :status, :category_id, :order_num, :location_id, :payment_method, :currency, :vendor_list,
          :location_searchable
          
  attr_accessible :order_goods_attributes # for nested form gem

  belongs_to :category  
  has_many :order_goods, :class_name => "OrderGoods", dependent: :destroy # here must specify the class_name as rails will resolve as order_good!
  has_many :order_price_histories, dependent: :destroy
  
  belongs_to :buyer, :class_name => "User", :foreign_key => 'buyer_id'
  belongs_to :vendor, :class_name => "User", :foreign_key => 'vendor_id'
  belongs_to :location, :class_name => "Location", :foreign_key => 'location_id'
  
  accepts_nested_attributes_for :order_goods, :allow_destroy => true
  accepts_nested_attributes_for :order_price_histories, :allow_destroy => true
   
   
  # pagination: page size for this model
  paginates_per 3
   
  # full-text search 
  searchable do
    text :order_num, :location_searchable
    time :create_time
    
    # the following do not work, as solr needs any data that comes from associations in your database is flattened down into your document.
    #text :order_goods do
     # order_goods.map { |order_gd| order_gd.order_goods_indexing_info  }      
     #order_goods.map { |order_gd| order_gd.name  } #  order_gd.model order_gd.memo TODO: how index multiple fields?  
     #order_goods.map { |order_gd| order_gd.model }
     #order_goods.map { |order_gd| order_gd.memo  }
    #end 
    
    text :order_goods_search
    
    text :category do
      category.name
    end
    
    text :vendor_search    
    text :buyer_search    
    
  end
  
  def order_goods_search
    self.order_goods.map{|item| (item.name ? item.name : '') + ',' + (item.model ? item.model : '') + ',' + (item.memo ? item.memo : '') + (item.category ? item.category : '') }.join(',')
  end

  def vendor_search
    if self.vendor && self.vendor.company
      self.vendor.company.name
    end
  end
  
   def buyer_search
    if self.buyer && self.buyer.company
      self.buyer.company.name
    end
  end
  
  
  
  def self.hot_tags    
     hashList = {}
     
    # allOrders = Order.all   
    # allOrders.each do |oneOrder|
      # oneOrder.order_goods.each do |good|
        # if good.name
          # hashList[good.name] = oneOrder # only the last one is kept...
        # end
      # end
    # end
    
    # get top 10 order goods...
    top10Goods = OrderGoods.select(" name, count(*) as name_counter " ).where("name is not null").group("name").order("name_counter DESC").limit(10)
    top10Goods.each do |g|
      if g.name
        hashList[g.name] = []
        orderGoods = OrderGoods.where(name: g.name)
        orderGoods.each do |goods|
          hashList[g.name] << goods.order_id
        end
      end
    end
   
    return hashList
  end
  
end
