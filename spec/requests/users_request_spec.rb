# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UnitTest of users controller', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:second_user)
  end

  describe 'GET signup_path' do
    it 'return success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Index' do
    context 'without login' do
      it 'is redirected to login path' do
        get users_path
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'Edit' do
    context 'without login' do
      it 'is redirected' do
        get edit_user_path(@user)
        expect(flash).not_to be_empty
        expect(response).to redirect_to login_url
      end
    end

    context 'by other user' do
      it 'is redirected to root_url' do
        log_in_as(@other_user)
        get edit_user_path(@user)
        expect(flash).to be_empty
        expect(response).to redirect_to root_url
      end
    end
  end

  describe 'Update' do
    context 'without login' do
      it 'is redirected' do
        patch user_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
        expect(flash).not_to be_empty
        expect(response).to redirect_to login_url
      end
    end

    context 'by other user' do
      it 'is redirected to root_url' do
        log_in_as(@other_user)
        patch user_path(@user), params: { user: { name: @user.name,
                                                  email: @user.email } }
        expect(flash).to be_empty
        expect(response).to redirect_to root_url
      end

      it 'is not allowed the admin attribute to be edited via the web' do
        log_in_as(@other_user)
        expect(@other_user.admin?).to be_falsey
        patch user_path(@other_user), params: { user: { password: @other_user.password,
                                                        password_confirmation: @other_user.password,
                                                        admin: true } }
        expect(@other_user.reload.admin?).to be_falsey
      end
    end
  end

  describe 'Destroy' do
    before do
      @admin_user = FactoryBot.create(:admin_user)
    end

    #  ログインしてない場合は削除できず、ログインページにリダイレクトされること
    context 'without login' do
      it 'is redirected' do
        expect {
          delete user_path(@user)
        }.to change(User, :count).by(0)
        expect(response).to redirect_to login_path
      end
    end

    # ログインしているがadminでない場合は削除できず、ユーザー一覧にリダイレクトされること
    context 'with login by general user' do
      it 'is redirected' do
        log_in_as(@user)
        expect {
          delete user_path(@admin_user)
        }.to change(User, :count).by(0)
        expect(response).to redirect_to users_path
      end
    end
  end
end
