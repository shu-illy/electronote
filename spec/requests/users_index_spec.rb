require 'rails_helper'

RSpec.describe "IntegrationTest of UsersIndex", type: :request do
  describe "User index" do
    before do
      @user = FactoryBot.create(:user)
      @admin_user = FactoryBot.create(:admin_user)
      @non_admin = FactoryBot.create(:user, name: "nonadmin", email: "nonadmin@test.com")
      99.times do |n|
        name  = "test#{n+1}"
        email = "test#{n+1}@electronote.net"
        FactoryBot.create(:user, name: name, email: email)
      end
    end

    context "as admin" do
      it "include pagination and delete links" do
        # ログイン
        # indexページにアクセス
        # 最初のページにユーザーがいることを確認
        # ページネーションのリンクがあることを確認
        # deleteリンクがあることを確認
        log_in_as(@admin_user)
        expect(@admin_user.admin?).to be_truthy
        get users_path
        expect(response).to render_template 'users/index'
        expect(Capybara.string(response.body)).to be_has_css '.pagination'
        first_page_of_users = User.paginate(page: 1)
        first_page_of_users.each do |user|
          expect(response.body).to match /[\S\s]*<a[\S\s]*href=\"#{user_path(user)}\">#{user.name}[\S\s]*/
          unless user.admin?
            expect(response.body).to match /[\S\s]*#{user_path(user)}\">delete[\S\s]*/
          end
        end
        expect {
            delete user_path(@non_admin)
          }.to change(User, :count).by(-1)
        end
    end

    context "as non-admin" do
      it "does not include delete links" do
        log_in_as(@non_admin)
        get users_path
        expect(response.body).not_to include "delete</a>"
      end
    end
    
  end
end
