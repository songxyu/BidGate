class Company < ActiveRecord::Base
  attr_accessible :register_address, :contact, :contact_tel, :legal_person, :main_biz, 
      :name, :register_capital, :account_num, :license_image
  
  has_many :user, :class_name => "User", dependent: :destroy
  
  def self.check_existing(p_account_num, p_legal_person)
    logger.debug " Company.verify: p_account_num= "+ p_account_num + ", p_legal_person=" + p_legal_person
    if p_account_num
      reged_comp = Company.where(account_num: p_account_num).first # DO NOT miss .first , otherwise, reged_comp.id will error!
      if reged_comp && reged_comp.legal_person == p_legal_person then
        logger.debug "=== Company.verify successfully!"
        return reged_comp
      else
        logger.debug "*** Company.verify failed!"
        return nil
      end
    end      
  end
end
