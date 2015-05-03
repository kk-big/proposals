class Proposal < ActiveRecord::Base

  belongs_to :branch, :foreign_key => "branch_cd", :primary_key => "branch_cd"

 # 地区本部
  validates :branch_cd,
    :presence => true
 # ユーザーID
  validates :user_id,
    :presence => true
 # 提案日
  validates :proposal_date,
    :presence => true
# # メールアドレス
#  validates :mail, 
#    allow_blank: true,
#    format: {with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, allow_blank: true, multiline: true, message: "の形式が違います。"}
 # 提案の分類
  validates :proposal_type, 
    :presence => {:message =>'のいずれかをチェックしてください'}
 # 事業の分類（→関連チェック）
  validates :project_type_a,:project_type_b,:project_type_c,:project_type_d,:project_type_e,:project_type_f, :if => :check_proposal_type?, 
    :acceptance => {:message =>'： 提案分類で（２）（３）を選択した場合、いずれかをチェックしてください'}
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

 # 関連チェック（事業の分類）
  def check_proposal_type?
    if proposal_type == "2" or proposal_type == "3"
      if project_type_a == "0" and
         project_type_b == "0" and
         project_type_c == "0" and
         project_type_d == "0" and
         project_type_e == "0" and
         project_type_f == "0"

         errors.add(:project_type_a, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")
         errors.add(:project_type_b, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")
         errors.add(:project_type_c, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")
         errors.add(:project_type_d, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")
         errors.add(:project_type_e, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")
         errors.add(:project_type_f, "提案分類で（２）（３）を選択した場合、いずれかを選択してください")

         errors.clear
      end
    end
  end

  # コンフリクトが起こる可能性がある更新処理
  def update_with_conflict_validation(*args)
    update(*args)
    rescue ActiveRecord::StaleObjectError
      self.lock_version = lock_version_was
      errors.add :base, "この商品は、あなたが編集中に他の人に更新されました。"
      changes.except("updated_at").each do |name, values|
      errors.add name, " #{values.first}"
    end
    false
  end

end
