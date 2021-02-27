require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  # describe "GET /users_signups" do
  #   it "works! (now write some real specs)" do
  #     get users_signups_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  
  describe "Invalid signup information" do
    # 不正な登録情報でユーザー数が変わらない(登録できない)ことを確認
    it "is rejected" do
      get signup_path
    end
  end

  # test "invalid signup information" do
  #   get signup_path
  #   assert_no_difference "User.count" do
  #     post users_path, params: { user: { name: "",
  #                                         email: "user@invalid",
  #                                         password: "foo",
  #                                         password_confirmation: "bar" } }
  #   end
  #   assert_template 'users/new'
  # end

  # test "valid signup information" do
  #   get signup_path
  #   assert_difference "User.count", 1 do
  #     post users_path, params: { user: { name: "Example User",
  #                                       email: "user@example.com",
  #                                       password: "password",
  #                                       password_confirmation: "password" } }
  #   end
  #   follow_redirect!
  #   assert_template 'users/show'
  #   assert_not flash.empty?
  # end


end
