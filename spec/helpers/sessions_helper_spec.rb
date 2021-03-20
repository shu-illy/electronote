# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe 'current_user' do
    # include RequestHelpers
    before do
      @user = FactoryBot.create(:user)
      remember(@user)
    end

    # 渡されたユーザーをrememberメソッドで記憶すると、渡されたユーザーとcurrent_userが一致すること
    it 'returns right user when session is nil' do
      expect(@user).to eq(current_user)
      expect(is_logged_in?).to be_truthy
    end

    # 渡されたユーザーの記憶ダイジェストと記憶トークンが正しく対応していない場合、currnt_userがnilになること
    it 'current_user returns nil when remember digest is wrong' do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be_nil
    end
  end
end
