# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IntegrationTest of users signup', type: :request do
  describe 'Invalid signup information' do
    # 不正な登録情報でユーザー数が変わらなず(登録できない)こと
    it 'is rejected with invalid registration' do
      get signup_path
      expect do
        post users_path, params: { user: { name: '',
                                           email: 'user@invalid',
                                           password: 'foo',
                                           password_confirmation: 'bar' } }
      end.to change(User, :count).by(0), 'User count changed'
      expect(response).to render_template('users/new'), 'user/new is not rendered'
    end

    # 有効な登録情報でユーザー数が代わり、showテンプレートに移動すること
    it 'is accepted with valid registration' do
      get signup_path
      expect do
        post users_path, params: { user: { name: 'Example User',
                                           email: 'user@example.com',
                                           password: 'password',
                                           password_confirmation: 'password' } }
      end.to change(User, :count).by(1), 'User count change is not correct'
      follow_redirect!
      expect(response).to render_template('users/show'), 'user/show is not rendered'
      expect(is_logged_in?).to be_truthy, 'is not logged in'
      expect(response.body).to include('alert-success'), 'redirect response does not have flash message'
    end
  end
end
