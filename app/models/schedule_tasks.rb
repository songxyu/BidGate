require 'logger'

class ScheduleTasks
  
  def self.update_order_status
    logger = Logger.new(STDOUT)
    # Rails.logger cannot accessed in initializer
    #Rails.logger.debug 'enter ScheduleTasks.update_order_status: '
    # ActiveSupport::Logger.debug 'enter ScheduleTasks.update_order_status: '
    logger.debug 'enter ScheduleTasks.update_order_status... '
    
    condition = " (orders.status = 0 or orders.status = 1) and deadline <= '" + DateTime.current.to_s + "'"
    #orders_to_be_updated = Order.where(condition)    
    #Rails.logger.debug  orders_to_be_updated.to_s
    
    Order.update_all('status = -2', condition)
    
    logger.debug 'exit ScheduleTasks.update_order_status. '
  end
  
  
end