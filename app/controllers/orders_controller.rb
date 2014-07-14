class OrdersController < CommonController
  include OrdersHelper
  include CategoriesHelper
  include OrderGoodsHelper
  
  before_filter  :authorize, :only => [:new, :edit, :create, :dashboard_orders]
  
  # TODO: fix issue using after_filter: Render and/or redirect were called multiple times in this action. Please note that you may only call render OR redirect, and at most once per action.
  #after_filter :common_response,  :only => [:show, :edit]  #:except => [:create, :update, :delete], 
    
  
  def index
    param_cate_id = params[:category_id] 
    order_id_list = params[:order_id_list]
    @filter_tag_name = params[:tag_name]
    @filter_category = param_cate_id ? Category.where(id: param_cate_id)[0] : nil
    
    visible_order_status = [0, 1, 2, 3, -1, -2] # TODO: should remove 3, -1, -2, currently show them only for debug 
    default_order_by = "create_time DESC" # NOTE: .order(create_time: :desc) seems not to work in rails 3.2!
    if param_cate_id
      @orders = Order.where(category_id: param_cate_id, status: visible_order_status).order(default_order_by).page(params[:page])
    elsif order_id_list
      @orders = Kaminari.paginate_array( Order.where(status: visible_order_status).find(order_id_list).sort {|x,y| y.create_time <=> x.create_time} ).page(params[:page])
    else
      @orders = Order.where(status: visible_order_status).order(default_order_by).page(params[:page])
    end
    
    # no need!
    #@orders.each do |oneOrder|
      #oneOrder.order_goods = OrderGoods.where(order_id: oneOrder.id)
      #oneOrder.order_price_histories = OrderPriceHistory.where(order_id: oneOrder.id)
      #oneOrder.vendor = User.find( oneOrder.vendor_id ) # no need do this!
      #oneOrder.buyer = User.find( oneOrder.buyer_id )
    #end
 
    logger.debug "Action: Order.index called finished... "     
  end
  
  
  def search
     search_keywords = params[:search] 
     # NOTE: params[] var is string!  
     filter_location_id = params[:search_location_id] 
     filter_category_id = params[:search_category_id] 
     filter_status = params[:search_status] 
     sort_by_id =  params[:search_sort_by]
     
     filter_location_id = filter_location_id ? filter_location_id.to_i : 0
     filter_category_id = filter_category_id ? filter_category_id.to_i : 0
     filter_status = filter_status ? filter_status.to_i : -99
     
     sort_by_id = sort_by_id ? sort_by_id.to_i : 0
     sort_by_arr = get_sortby_arr_by_id(sort_by_id)
          
     logger.debug "Search keywords param=" + search_keywords \
                + ", filter_location_id= " + filter_location_id.to_s   \
                + ", filter_category_id= " + filter_category_id.to_s  \
                + ", filter_status= " + filter_status.to_s  \
                + ", sort_by_str= " + sort_by_arr.to_s       
     
 
     
     
     @search = Order.search do
        fulltext search_keywords 
        with(:location_id, filter_location_id) unless filter_location_id <= 0 # if 0, remove this scope to hit all records
        with(:category_id, filter_category_id) unless filter_category_id <= 0
        with(:status, filter_status) unless filter_status <= -3
        
        order_by sort_by_arr[0], sort_by_arr[1]  # two symbols  #:create_time, :desc 
               
        paginate :page => params[:page], :per_page => 10
     end
     @orders = @search.results
     
     # get location list 
     @location_array = Location.all.map { |loc| [loc.full_location_name, loc.id] }
     @location_array.sort {|a,b| a[0] <=> b[0] } # sort by name
     @location_array.unshift(["全国", 0]) 
     
     # all category list
     @category_array = Category.all.map { |cat| [cat.name, cat.id] } 
     @category_array.sort {|a,b| a[0] <=> b[0] } # sort by name
     @category_array.unshift(["所有", 0]) 
     
     #all status list
     @status_array = OrdersHelper.get_all_status()
     @status_array.unshift(["所有", -99]) 
     
     # sortby list
     @sortby_array = OrdersHelper.get_sortby_criteria()
     
     logger.debug "Search result count: " + @orders.count.to_s
     render "index"  
  end
  
  def get_sortby_arr_by_id (id)
    default_sort = [:create_time,  :desc] # use symbol array
    case id
    when 1
      default_sort
    when 2
      [:deadline, :asc] 
    when 3
      [:price, :asc]
    when 4
      [:price, :desc]
    when 5
      [:goods_total_quantity_search_sorting, :asc]
    when 6
      [:goods_total_quantity_search_sorting, :desc]
    else
      default_sort
    end
  end
  
  
  def new
    @order = Order.new
    @category = Category.where(parent_id: 0)
    #common_response # use new.js.erb instead of common one, due to some special js handle
  end
  
  def create 
    # new param list:
=begin    
    {"utf8"=>"✓",
     "authenticity_token"=>"tTolOrDsZGyImStWzUWlea+aCObGZ4WTS5iKcIXSBss=",
     "parent_category"=>"3",
     "category"=>"10",
     "order"=>{
       "order_goods_attributes"=>{
         "0"=>{"name"=>"1",
               "model"=>"1",
               "price"=>"1",
               "quantity"=>"1",
               "_destroy"=>"false"},
         "1387295983613"=>{"name"=>"2",
               "model"=>"2",
               "price"=>"2",
               "quantity"=>"2",
               "_destroy"=>"false"}
        },
     "price"=>"222",
     "price_type"=>"1",
     "deadline"=>"2013-12-20"
     }}
=end
   # @params = ActiveSupport::JSON.decode( )
    
    puts   params
     
    #@parent_category = Category.find(params[:parent_category])    
    cateId = params[:category]
    #cateId = cateId ? cateId : params[:parent_category]
    @category = Category.find(cateId)
    
    # order number use time with millsec
    str_time_millsec = Time.now.strftime('%Y%m%d%H%M%S%L')
    loc_name = params[:location]
    delivery_date = params[:delivery_date]
    
    puts   cateId
    puts   loc_name
    puts   delivery_date
    
    
    
    @order = Order.new(order_num: str_time_millsec, create_time: DateTime.current, deadline: params[:deadline],
      price: params[:price], buyer_id: session[:user_id], vendor_id: nil, price_type: params[:price_type], 
      status: 1, category_id: cateId, currency: 1, vendor_list: params[:vendor_list], order_memo: params[:memo],
      payment_method: params[:payment_method], location_id: 1, location_searchable: loc_name )
       
    puts "params[:order_items]: ", params[:order_items] 
    
    arrOrderGoods = [] # item props without dynamic ones
    arrDynamicProps = [] # item dynamic props  
    filledOrderGoods = params[:order_items] # :order_goods_attributes] #params[:order_goods];
    order_goods_seq = 0
    filledOrderGoods.each do |key, valueArr|
      puts 'valueArr: ', valueArr      
      valueArr['category'] = @category.name
      valueArr.delete("id")
      valueArr.delete("operation")
      valueArr.delete("location")
      #valueArr.delete("_destroy") # remove the unused field "_destroy", added by nested-form gem
      
      #@one_order_goods = OrderGoods.new({name:valueArr['name'], model: valueArr['model'], price: nil, 
      #  quantity: valueArr['quantity'], memo: valueArr['memo'], category: valueArr['category']})
      
      # handle dynamic props: save to array arrDynamicProps
      dynamicPropsObj = {} 
      dynPropPrefix = 'category-dynamic-prop-'
      valueArr.each do |propKey, propVal|
        idx = propKey.index(dynPropPrefix)
        if idx != nil
          startIdx = idx+dynPropPrefix.length
          realDynPropKey = propKey[startIdx, propKey.length-startIdx]
          
          dynamicPropsObj[realDynPropKey] = propVal
          valueArr.delete(propKey)
        else
         #arrOrderGoods.append( [propKey, propVal] )          
        end
      end
      
      dynamicPropsObj['order_goods_seq'] = order_goods_seq
      puts 'dynamicPropsObj:', dynamicPropsObj
      
      arrDynamicProps << dynamicPropsObj
      #@one_order_goods.goods_exts.build(arrDynamicProps) # not work!
      
      arrOrderGoods <<  valueArr      
      
      order_goods_seq += 1
    end
    puts 'arrDynamicProps: ', arrDynamicProps
    puts 'arrOrderGoods:', arrOrderGoods
    
    # usage sample: 
    # arrOrderGoods = []
    # filledOrderGoods = params[:order_goods_attributes] #params[:order_goods];
    # filledOrderGoods.each do |key, valueArr|
      # puts valueArr
      # #valueArr['category'] = @category.name
      # #valueArr.delete("_destroy") # remove the unused field "_destroy", added by nested-form gem
      # arrOrderGoods << valueArr
    # end
    
    @order.order_goods.build(arrOrderGoods)     
    @order.save   
        
    logger.debug "@order.order_goods: "+ @order.order_goods.to_s
    @order.order_goods.each_with_index  do |goods_val, goods_index|
      goods_id = goods_val.id  
      logger.debug 'goods_id: '+ goods_id.to_s + ', goods_index: '+ goods_index.to_s
         
      arrDynamicProps.each do |propGroupVal, propGroupIndex|       
       if goods_index == propGroupVal['order_goods_seq']
         logger.debug 'propGroupVal: '+ propGroupVal.to_s
         propGroupVal.each do |propKey, propVal|
           if propKey.to_i > 0
             GoodsExt.addOneExtProp(propKey, goods_id, propVal)
             logger.debug 'inserted: propKey:'+ propKey + ', goods_id: '+ goods_id.to_s + ', propVal: '+ propVal
           end 
         end
       end
      end
    end
    
    redirect_to @order
  end
  

  
  def show
    @order = Order.find(params[:id])
    @dynamic_goods_props = CategoriesHelper.get_dyn_props_by_category(@order.category_id)
    @category_unit = CategoriesHelper.get_category_unit(@order.category_id)
    # from_path = params[:form_path];
     # no need do this!
    #@order.vendor = User.find( @order.vendor_id )
    #@order.buyer = User.find( @order.buyer_id )
      respond_to do |format|
            format.js
          end
  end
  
  def quickview_show
    @order = Order.find(params[:order_id])
    respond_to do |format|
            format.js
    end
  end
  
  def comm_dialog_show
#    @order = Order.find(params[:buyer_id])
    respond_to do |format|
            format.js
    end
  end
  
  def edit
    @order = Order.find(params[:id])
    common_response
  end
    
    
  def order_detail_params
    params.require(:order).permit(:deadline, :price, :price_type, 
      order_goods_attributes: [:name, :model, :price, :quantity, :_destroy]) # when remove, need _destroy
  end
  
 
  # default, load all tabs' data
  def dashboard_purchase_orders
    user_id = current_user.id
    #status = params[:status]
    page_info = params[:page]
    
    @bidding_orders = OrdersHelper.my_purchases(user_id, 1, page_info)
    @forpaid_orders = OrdersHelper.my_purchases(user_id, 2, page_info)
    @complete_orders = OrdersHelper.my_purchases(user_id, 3, page_info)
    @all_orders = OrdersHelper.my_purchases(user_id, nil, page_info)
    render "dashboard/dashboard_purchases" and return
  end
  
  def dashboard_purchase_orders_all
    user_id = current_user.id
    page_info = params[:page]
    
    @all_orders = OrdersHelper.my_purchases(user_id, nil, page_info)
    render "dashboard/dashboard_purchases" and return
  end
  
  def dashboard_purchase_orders_forpaid
    user_id = current_user.id
    page_info = params[:page]
    
    @forpaid_orders = OrdersHelper.my_purchases(user_id, 2, page_info)
    render "dashboard/dashboard_purchases" and return
  end
  
  def dashboard_purchase_orders_complete
    user_id = current_user.id
    page_info = params[:page]
    
    @complete_orders = OrdersHelper.my_purchases(user_id, 3, page_info)
    render "dashboard/dashboard_purchases" and return
  end
  
  # orders in bidding process, my purchased orders!
  def dashboard_purchase_orders_bidding
    user_id = current_user.id
    page_info = params[:page]
    
    @bidding_orders = OrdersHelper.my_purchases(user_id, 1, page_info)
    render "dashboard/dashboard_purchases" and return
  end
  
  # default, load all tabs' data
  def dashboard_vending_orders
    user_id = current_user.id
    #status = params[:status]
    page_info = params[:page]
    
    @bidding_orders = OrdersHelper.my_biddings(user_id, 1, page_info)
    @fail_bidding_orders = OrdersHelper.my_biddings_failed(user_id, page_info)
    @dealed_orders = OrdersHelper.my_vendings(user_id, 2, page_info)
    @complete_orders = OrdersHelper.my_vendings(user_id, 3, page_info)
    @all_orders = OrdersHelper.my_vendings(user_id, nil, page_info)
    
    render "dashboard/dashboard_vendings" and return
  end
  
  def dashboard_vending_orders_all
    user_id = current_user.id
    page_info = params[:page]
    @all_orders = OrdersHelper.my_vendings(user_id, nil, page_info)
    render "dashboard/dashboard_vendings" and return
  end
  
  def dashboard_vending_orders_dealed
    user_id = current_user.id
    page_info = params[:page]
    
    @dealed_orders = OrdersHelper.my_vendings(user_id, 2, page_info)
    render "dashboard/dashboard_vendings" and return
  end
  
  def dashboard_vending_orders_complete
    user_id = current_user.id 
    page_info = params[:page]
    
    @complete_orders = OrdersHelper.my_vendings(user_id, 3, page_info)
    render "dashboard/dashboard_vendings" and return
  end
  
  def dashboard_vending_orders_bidding
    user_id = current_user.id
    page_info = params[:page]
    
    @bidding_orders = OrdersHelper.my_biddings(user_id, 1, page_info)
    render "dashboard/dashboard_vendings" and return
  end
  
  def dashboard_vending_orders_fail_bidding
    user_id = current_user.id
    page_info = params[:page]
    
    @fail_bidding_orders = OrdersHelper.my_biddings_failed(user_id, page_info)    
    render "dashboard/dashboard_vendings" and return
  end
  
  
  
  # buyer approves a bid
  def approve_bid
    order_id = params[:order_id]
    bid_history_id = params[:price_history_id]
    user_id = current_user.id
    
    @order = Order.find(order_id)
    if @order
      if user_id == @order.buyer.id
        @order_hist = OrderPriceHistory.find(bid_history_id)
        @order.vendor_id = @order_hist.vendor_id
        @order.deal_price = @order_hist.price
        @order.deal_date =  DateTime.current
        
        if @order.save
           logger.debug "order approved, dealed.  for order_id = " + order_id.to_s
           flash.now.notice = "竞拍成交!"
        else
          logger.error "order approved failed  for order_id = " + order_id.to_s
          flash.now.alert = "竞拍未能成交!"
        end
      else
         logger.error "order approved failed, buyer not correct. for order_id = " + order_id.to_s
         flash.now.alert = "竞拍未能成交!"
      end      
     else
         logger.error "order approved failed, not found. for order_id = " + order_id.to_s
         flash.now.alert = "竞拍未能成交!!"
     end
        
  end
  
  
  def cancel_bid
    order_id = params[:order_id]
    user_id = current_user.id
    
    @order = Order.find(order_id)    
    @order.update_attribute(:status, -1)    
  end
  
end