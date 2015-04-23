class Proposal < ActiveRecord::Base

 # 地区本部
  validates :branch_cd,
    :presence => true
 # ユーザーID
  validates :user_id,
    :presence => true
 # 提案日
  validates :proposal_date,
    :presence => true
 # メールアドレス
  validates :mail, 
    allow_blank: true,
    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, allow_blank: true, multiline: true, message: "の形式が違います。"}
 # 提案の分類
  validates :proposal_type, 
    :presence => true
 # 提案の題名
  validates :proposal_title, 
    :presence => true
 # 現状と問題点
  validates :now_problem, 
    :presence => true
 # 具体的提案
  validates :proposal_detail, 
    :presence => true
 # 予想される効果
  validates :effect, 
    :presence => true

end
