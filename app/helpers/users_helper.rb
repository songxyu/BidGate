module UsersHelper
  extend self
  
  def checkUserEmailUnique(mail, id)
    @retUser = User.where("email = ? and id <> ?", mail, id)
    Rails.logger.debug "checkUserEmailUnique: "+@retUser.to_s
    return @retUser.length>0 ? false : true
  end
  
   def checkUserUsernameUnique(name, id)
    @retUser = User.where("username = ? and id <> ?", name, id)
    Rails.logger.debug "checkUserUsernameUnique: "+ @retUser.to_s
    return @retUser.length>0 ? false : true
  end
  
  #职责:  0: 未指定,  1: 采购,  2: 销售,  3: 销售经理 
  def getContactTitles
    return [["未指定", 0], ["采购", 1], ["销售", 2], ["销售经理", 3]]
  end
  
  def getContactTitleText(titleKey)
    case titleKey
      when 1 then "采购"
      when 2 then "销售" 
      when 3 then "销售经理"
      else "未指定"
    end
  end
  
end
