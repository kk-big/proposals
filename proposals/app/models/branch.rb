class Branch < ActiveRecord::Base

 # 地区本部
  validates :branch_cd,
    :presence => true

 # 地区本部名
  validates :branch_name,
    :presence => true

end
