module ApplicationHelper

# nav bar リンクアクティブ
  def add_active(name)
    return "active" if name.include?(controller.controller_name)
  end

# nav bar リンクアクティブ（パスワード変更）
  def add_active_personal(name)
    if session[:role] == '1'
      return "active" if name.include?(controller.controller_name)
    end
  end

# 年月日をスラッシュ編集
  def yyyymmdd_slash(yyyymmdd)
    if yyyymmdd.blank?
    else
     return yyyymmdd[0,4] + '/' + yyyymmdd[4,2] + '/' + yyyymmdd[6,2]
    end
  end

# 今日の年月日を返す
  def getToday()
    require "date"
    d = Date.today
    return d.year.to_s + sprintf("%02d", d.month).to_s + sprintf("%02d", d.day).to_s 
  end

end
