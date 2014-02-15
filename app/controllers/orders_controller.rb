class OrdersController < CommonController
  #include ResponseUtil
  
  # TODO: fix issue using after_filter: Render and/or redirect were called multiple times in this action. Please note that you may only call render OR redirect, and at most once per action.
  #after_filter :common_response,  :only => [:show, :edit]  #:except => [:create, :update, :delete], 
    
  
  def index
    param_cate_id = params[:category_id] 
    order_id_list = params[:order_id_list]
    @filter_tag_name = params[:tag_name]
    @filter_category = param_cate_id ? Category.where(id: param_cate_id)[0] : nil
    
    visible_order_status = [0, 1, 2]
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
     sort_by_id =  params[:search_sort_by]
     
     filter_location_id = filter_location_id ? filter_location_id.to_i : 0
     filter_category_id = filter_category_id ? filter_category_id.to_i : 0
     sort_by_id = sort_by_id ? sort_by_id.to_i : 0
     sort_by_arr = get_sortby_arr_by_id(sort_by_id)
          
     logger.debug "Search keywords param=" + search_keywords \
                + ", filter_location_id= " + filter_location_id.to_s   \
                + ", filter_category_id= " + filter_category_id.to_s  \
                + ", sort_by_str= " + sort_by_arr.to_s       
     
 
     
     
     @search = Order.search do
        fulltext search_keywords 
        with(:location_id, filter_location_id) unless filter_location_id <= 0 # if 0, remove this scope to hit all records
        with(:category_id, filter_category_id) unless filter_category_id <= 0
        
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

    #@parent_category = Category.find(params[:parent_category])    
    cateId = params[:category]
    cateId = cateId ? cateId : params[:parent_category]
    @category = Category.find(cateId)
    
    # order number use time with millsec
    str_time_millsec = Time.now.strftime('%Y%m%d%H%M%S%L')
    
    @order = Order.new(order_num: str_time_millsec, create_time: DateTime.current, deadline: params[:order][:deadline],
      price: params[:order][:price], buyer_id: session[:user_id], vendor_id: nil, price_type: params[:order][:price_type], 
      status: 1, category_id: @category.id)
    
    arrOrderGoods = []
    filledOrderGoods = params[:order][:order_goods_attributes] #params[:order_goods];
    filledOrderGoods.each do |key, valueArr|
      puts valueArr
      valueArr['category'] = @category.name
      valueArr.delete("_destroy") # remove the unused field "_destroy", added by nested-form gem
      arrOrderGoods << valueArr
    end
    
    #puts arrOrderGoods
    @order.order_goods.build(arrOrderGoods) 
        
    @order.save       
    redirect_to @order
  end
  

  
  def show
    @order = Order.find(params[:id])
     # no need do this!
    #@order.vendor = User.find( @order.vendor_id )
    #@order.buyer = User.find( @order.buyer_id )
    common_response  
  end
  
  def edit
    @order = Order.find(params[:id])
    common_response
  end
    
    
  def order_detail_params
    params.require(:order).permit(:deadline, :price, :price_type, 
      order_goods_attributes: [:name, :model, :price, :quantity, :_destroy]) # when remove, need _destroy
  end
  
  

  
  
end