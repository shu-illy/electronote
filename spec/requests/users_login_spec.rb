# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IntegrationTest of user login', type: :request do
  describe 'user login' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'valid email and invalid password' do
      it 'fails in login and displays flash message' do
        get login_path
        expect(response).to render_template('sessions/new')
        post login_path, params: { session: { email: @user.email, password: 'invalid' } }
        expect(is_logged_in?).to be_falsey, 'invalid log_in is not rejected'
        expect(response).to render_template('sessions/new')
        expect(flash[:danger]).to be_truthy, 'flash message is empty'
        get root_path
        expect(flash[:danger]).to be_falsey, 'flash message is not empty'
      end
    end

    context 'valid user' do
      include UsersHelper
      it 'succeeds in login followed by logout' do
        get login_path
        expect(response).to render_template('sessions/new')
        post login_path, params: { session: { email: @user.email, password: @user.password } }
        expect(is_logged_in?).to be_truthy, 'not logged in'
        expect(response).to redirect_to(@user), 'not redirected to @user'
        follow_redirect!
        expect(response).to render_template('users/show'), "does not render 'user/show' template"
        assert_select 'a[href=?]', login_path, count: 0
        assert_select 'a[href=?]', logout_path
        assert_select 'a[href=?]', user_path(@user)
        delete logout_path
        expect(is_logged_in?).to be_falsey, 'not lotted out'
        expect(response).to redirect_to(root_url), 'not redirected to root_url'
        # 2番目のウィンドウでログアウトする動作を想定
        delete logout_path
        follow_redirect!
        assert_select 'a[href=?]', login_path
        assert_select 'a[href=?]', logout_path, count: 0
        assert_select 'a[href=?]', user_path(@user), count: 0
      end
    end

    # 「ログインしたままにする」にチェックを入れると記憶トークンが保持され、クッキーの記憶トークンとインスタンス変数のremember_tokenが一致すること
    context 'login with remembering' do
      it 'keep remember_token' do
        log_in_as(@user, remember_me: '1')
        expect(cookies[:remember_token]).to eq(assigns(:user).remember_token)
      end
    end

    # 「ログインしたままにする」のチェックを外すと記憶トークンが保持されないこと
    context 'login without remembering' do
      it 'does not keep remember_token' do
        log_in_as(@user, remember_me: '1')
        delete logout_path
        log_in_as(@user, remember_me: '0')
        expect(cookies[:remember_token]).to be_empty
      end
    end
  end
end
