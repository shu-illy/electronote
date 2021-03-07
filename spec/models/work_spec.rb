require 'rails_helper'

RSpec.describe Work, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @work = FactoryBot.create(:work, user: @user)
  end

  describe "Work" do
    it "is valid" do
      expect(@work).to be_valid
    end

    it "is posted by present user" do
      @work.user_id = nil
      expect(@work).to be_invalid
    end

  end

  describe "Title of work" do
    it "is present" do
      @work.title = " "
      expect(@work).to be_invalid
    end

    it "is not longer than 100characters" do
      @work.title = "a" * 101
      expect(@work).to be_invalid
    end
  end

  describe "Orders of works" do
    let!(:day_before_yesterday) { FactoryBot.create(:work, :day_before_yesterday, user: @user) }
    let!(:now) { FactoryBot.create(:work, :now, user: @user) }
    let!(:yesterday) { FactoryBot.create(:work, :yesterday, user: @user) }
    
    # 最新の投稿が一番上に来ること
    it "is most recent first" do
      expect(Work.first).to eq(now)
    end
  end

end
