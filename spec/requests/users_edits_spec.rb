require 'rails_helper'

RSpec.describe "UsersEdits", type: :request do
  describe "User edit" do
    
    before do
      @user = FactoryBot.create(:user)
    end
    # 編集失敗のテスト
    context "with invalid parameters" do
      # 編集失敗し、編集ページがレンダリングされる
      it "is rejected and render edit page" do
        log_in_as(@user)
        get edit_user_path(@user)
        expect(response).to render_template('users/edit')
        patch user_path(@user), params: { user: {name: "",
                                                email: "foo@invalid",
                                                password: "foo",
                                                password_confirmation: "bar" } }
        expect(response.body).to include "The form contains 4 errors"
        expect(response).to render_template('users/edit')
      end
    end

    # 編集成功のテスト
    context "with valid parameters" do
      it "is accepted" do
        log_in_as(@user)
        get edit_user_path(@user)
        expect(response).to render_template('users/edit')
        name = "Foo Bar"
        email = "foo@bar.com"
        patch user_path(@user), params: { user: {name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
        expect(flash).not_to be_empty
        expect(response).to redirect_to(@user)
        @user.reload
        expect(@user.name).to eq(name)
        expect(@user.email).to eq(email)
      end
    end

    context "after login" do
      # フレンドリーフォワーディングのテスト
      it "is redirected with friendly forwarding" do
        # ログイン前にeditページにアクセス、ログインページがレンダリングされてからログインすると、
        # 意図していたページ(編集ページ)にリダイレクトされること
        get edit_user_path(@user)
        log_in_as(@user)
        expect(response).to redirect_to edit_user_path(@user)
        expect(session[:forwarding_url]).to be_nil
      end
    end

  end
end
