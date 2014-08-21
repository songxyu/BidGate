# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
BidGate::Application.initialize!


# config for activemerchant and activemerchant_patch_for_china as gems
config.gem "activemerchant", :lib => "active_merchant"
config.gem "activemerchant_patch_for_china", :lib => false


require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)