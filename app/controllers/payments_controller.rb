class PaymentsController < ApplicationController
  #include PayFu::PaypalHelper
  include PayFu::AlipayHelper
  
  include OrdersHelper

  def create
    @payment = Payment.new(params[:payment]) # need two params amount and order_id
    if @payment.valid?
      #@payment.quantity = Guid.new.to_s.gsub('-', '')
      
      case @payment.currency
        when "USD"
          #redirect_to_paypal_gateway(:item_name => @payment.subject, :amount => @payment.amount)
          return
        when "RMB"
          redirect_to_alipay_gateway(:subject => @payment.subject, :body => @payment.body, :amount => @payment.amount,
                                     :out_trade_no => @payment.order_id, :notify_url => pay_fu.alipay_transactions_notify_url)
      end
    else
      #render :index
    end
  end

  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    transaction_attributes = {
        :total_fee    => notification.total_fee,
        :trade_status => notification.trade_status,
        :trade_no     => notification.trade_no,
        :notify_type  => notification.notify_type,
        :notify_time  => notification.notify_time,
        :buyer_alipay_account  => notification.buyer_email,
        :discount     => notification.discount,
        :order_id     => notification.order_id,
        :gmt_create   => notification.gmt_create,
        :gmt_payment  => notification.gmt_payment

        #:raw_post     => rnotificationequest.raw_post
    }

    if transaction = Transaction.find_by_notify_id(notification.notify_id)
      result = transaction.update_attributes(transaction_attributes)
    else
      transaction_attributes.merge!(:notify_id => notification.notify_id)
      result = Transaction.create(transaction_attributes)
    end

    if result
      render :text => "success" # must respond to alipay server with this
    else
      render :text => "failure"
    end
  end


  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    if r.success?
      flash[:notice] = '支付成功！'
    else
      flash[:error] = '支付失败！'
    end
    
    # TODO:
    redirect_to root_path
  end



end