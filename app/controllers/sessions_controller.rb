class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ログイン後にユーザー情報のページにリダイレクト
      log_in user
      redirect_to user
    else
      # エラーメッセージを返してnewをレンダリング
      flash.now[:danger] = "メールアドレスまたはパスワードが正しくありません"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
