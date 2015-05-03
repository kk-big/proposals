class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy, :thanks_update]

  # GET /proposals
  # GET /proposals.json
  def index
#    if  session[:user_id].nil?
    if  $user.blank?
      redirect_to root_path and return
    end

#    @proposals = Proposal.joins(:user)

    strsql = 'select 
                pu.id as id , pu.branch_cd as branch_cd, pu.user_id as user_id, pu.proposal_date as proposal_date, pu.section_name1 as section_name1, pu.section_name2 as section_name2,
                pu.proposal_type as proposal_type,
                pu.project_type_a as project_type_a, pu.project_type_b as project_type_b, pu.project_type_c as project_type_c, pu.project_type_d as project_type_d, pu.project_type_e as project_type_e, pu.project_type_f as project_type_f, 
                pu.proposal_title as proposal_title, pu.now_problem as now_problem, pu.proposal_detail as proposal_detail, pu.effect as effect,
                pu.user_name as user_name,
                branches.branch_name as branch_name
                from
                (select
                proposals.id as id, proposals.branch_cd as branch_cd, proposals.user_id as user_id, proposals.proposal_date as proposal_date, proposals.section_name1 as section_name1, proposals.section_name2 as section_name2,
                proposals.proposal_type as proposal_type,
                proposals.project_type_a as project_type_a, proposals.project_type_b as project_type_b, proposals.project_type_c as project_type_c, proposals.project_type_d as project_type_d, proposals.project_type_e as project_type_e, proposals.project_type_f as project_type_f, 
                proposals.proposal_title as proposal_title, proposals.now_problem as now_problem, proposals.proposal_detail as proposal_detail, proposals.effect as effect,
                users.user_name as user_name
                from proposals as proposals left join users as users on proposals.branch_cd = users.branch_cd and proposals.user_id = users.user_id) as pu
              left join branches as branches on pu.branch_cd = branches.branch_cd'

    if session[:role] == '1'
      strsql = strsql + " where pu.branch_cd = '" + session[:branch_cd] + "' and pu.user_id = '" + session[:user_id] + "'"
    end

    strsql = strsql + " order by id"

    @proposals = Proposal.find_by_sql([strsql])

  end

  # GET /proposals/1
  # GET /proposals/1.json
  def show
  end

  # GET /proposals/new
  def new
    @proposal = Proposal.new
  end

  # GET /proposals/1/edit
  def edit
  end

  # POST /proposals/0/confirm
  def confirm
    @proposal = Proposal.new(proposal_params)

    if @proposal.valid?
      render :action => 'confirm'
    else
      render :action => 'new'
    end
  end

  # POST /proposals/0/confirm_update
  def confirm_update
    @proposal = Proposal.new(proposal_params)

    if @proposal.valid?
      render :action => 'confirm_update'
    else
      render :action => 'update'
    end
  end

  # POST /citizens/0/thanks
  def thanks
    @proposal = Proposal.new(proposal_params)

    if params[:back]
      render :action => 'new' and return
    end

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to proposals_path, notice: '提案を1件登録しました。' }
#        format.html { redirect_to @proposal, notice: '提案を1件登録しました。' }
        format.json { render :show, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /proposals/0/thanks
  def thanks_update
    if params[:back]
      render :action => 'edit' and return
    end

    respond_to do |format|
#      if @proposal.update(proposal_params)
#        format.html { redirect_to @proposal, notice: '提案を1件更新しました。' }
      if @proposal.update_with_conflict_validation(proposal_params)
        format.html { redirect_to proposals_path, notice: '提案を1件変更しました。' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /proposals
  # POST /proposals.json
  def create
    @proposal = Proposal.new(proposal_params)

    # 提案日セット
#    require "date"
#    d = Date.today
#    strdate = d.year.to_s + sprintf("%02d", d.month).to_s + sprintf("%02d", d.day).to_s 
#    @proposal.proposal_date = strdate

    respond_to do |format|
      if @proposal.save
#        format.html { redirect_to proposals_path, notice: '提案を1件登録しました。' }
        format.html { redirect_to @proposal, notice: '提案を1件登録しました。' }
        format.json { render :show, status: :created, location: @proposal }
      else
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proposals/1
  # PATCH/PUT /proposals/1.json
  def update
    respond_to do |format|
#      if @proposal.update(proposal_params)
      if @proposal.update_with_conflict_validation(proposal_params)
        format.html { redirect_to @proposal, notice: '提案を1件更新しました。' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proposals/1
  # DELETE /proposals/1.json
  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:id, :branch_cd, :user_id, :proposal_date, :section_name1, :section_name2, :mail, :tel, :proposal_type, :project_type_a, :project_type_b, :project_type_c, :project_type_d, :project_type_e, :project_type_f, :proposal_title, :now_problem, :proposal_detail, :effect, :lock_version)
    end
end
