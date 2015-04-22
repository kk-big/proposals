class User < ActiveRecord::Base

  belongs_to :branch, :foreign_key => "branch_cd", :primary_key => "branch_cd"

 # 地区本部
  validates :branch_cd,
    :presence => true
 # 社員名
  validates :user_name,
    :presence => true
 # ユーザーID
  validates :user_id,
    :uniqueness => { scope: [:branch_cd] },
    :presence => true,
    :format => { with: /\A[a-z0-9]+\z/i }
 # ユーザーパスワード
  validates :user_password,
    :presence => true,
    :confirmation => true,
    :length => { maximum: 16 },
    :format => { with: /\A[a-z0-9]+\z/i }
 # メールアドレス
  validates :mail, 
    allow_blank: true,
    length: {maximum: 255},
    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, allow_blank: true, multiline: true, message: "の形式が違います。"}

end
