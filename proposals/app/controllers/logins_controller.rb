class LoginsController < ApplicationController
  layout "login"

  def index
    session[:user_id] = nil
    render "new"
  end

  def new
  end

  def log
    if Branch.where(branch_name: params[:branch_name][:name]).exists?
      session[:branch_name] = params[:branch_name][:name]
      @branch = Branch.where(branch_name: params[:branch_name][:name])
      session[:branch_cd] = @branch.first.try(:branch_cd)
    else
      @flash_now_alert = "もう一度入力してください。"
      render "new"     
    end
    if User.where(user_id: params[:login_id], :user_password => params[:login_pass],delete_flag: "0").exists?
      session[:user_id] = params[:login_id]
      @user = User.where(user_id: params[:login_id], :user_password => params[:login_pass],delete_flag: "0")
      $user = @user.first
      session[:user_name] = @user.first.try(:user_name)
      session[:role] = @user.first.try(:role)
      redirect_to proposals_path
    else
      @flash_now_alert = "もう一度入力してください。"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def set_action_name
    session[:action_name] = params[:action_name]
    return true
  end
end
