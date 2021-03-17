require 'rails_helper'

RSpec.describe User, type: :model do

  describe User do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                          password: "foobar", password_confirmation: "foobar")
    end
    
    # 有効であること
    it "is valid" do
      expect(@user).to be_valid
    end

    # 名前が空白であれば無効になること
    it "is invalid with empty first name" do
      @user.name = " "
      expect(@user).to be_invalid
    end
    
    # メールアドレスが空白であれば無効になること
    it "is invalid with empty email address" do
      @user.email = " "
      expect(@user).to be_invalid
    end

    # 長過ぎる名前(51文字以上)は無効になること
    it "is invalid with too long name" do
      @user.name = "a" * 51
      expect(@user).to be_invalid
    end

    # 長すぎるメールアドレス(244文字以上)は無効であること(ドメイン除く)
    it "is invalid with too long email" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user).to be_invalid
    end

    # メールアドレスに重複がないこと
    it "is invalid with duplicate email" do
      duplicate_user = @user.dup
      @user.save
      expect(duplicate_user).to be_invalid
    end

    # 有効なフォーマットのメールアドレスが通ること
    it "is accepted with valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid, "#{valid_address.inspect} is rejected"
      end
    end

    # 無効なフォーマットのメールアドレスが通らないこと
    it "is rejected with invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.nae@example. foo@bar_baz.com fo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to be_invalid, "#{invalid_address.inspect} is accepted"
      end
    end

    # メールアドレスがlower caseで保存されていること
    it "is saved with lower-case addresses" do
        mixed_case_email = "Foo@ExAMPle.CoM"
        @user.email = mixed_case_email
        @user.save
        expect(mixed_case_email.downcase).to eq(@user.reload.email)
    end

    # パスワードが空でないこと
    it "has nonblank password" do
      @user.password = @user.password_confirmation = " " * 6
      expect(@user).to be_invalid
    end

    # 最低長さ(6文字)より短いパスワードが無効になること
    it "is invalid when password is shorter than 6 letters" do
      @user.password = @user.password_confirmation = "a" * 5
      expect(@user).to be_invalid
    end

    # ブラウザにcookiesがあるが、アプリ側で記憶ダイジェストがない場合にユーザー認証が無効になる
    it "is invalid without remember_digest" do 
      expect(@user.authenticated?('')).to be_falsey
    end

    # ユーザーを削除したら投稿も削除されること
    it "is deleted with associated works" do
      @user.save
      FactoryBot.create(:work, user: @user)
      expect {
        @user.destroy
      }.to change(Work, :count).by(-1)
    end

  end

end
