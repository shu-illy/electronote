require 'rails_helper'

RSpec.describe "Works", type: :request do

  # before do
  #   test_user = FactoryBot.create(:user)
  #   test_work = FactoryBot.create(:work, user: test_user)
  # end

  let!(:test_user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:second_user) }
  let!(:test_work) { FactoryBot.create(:work, user: test_user) }

  describe "Create" do
    context "when not log in" do
      it "is redirected" do
        expect{
          post works_path, params: { work: { title: "Test circuit" } }
        }.to change(Work, :count).by(0)
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "Destroy" do
    context "when not log in" do
      it "is redirected" do
        expect{
          delete work_path(test_work)
        }.to change(Work, :count).by(0)
        expect(response).to redirect_to login_url
      end
    end

    context "by wrong user" do
      it "is redirected" do
        log_in_as(test_user)
        wrong_work = FactoryBot.create(:work, user: other_user)
        expect {
          delete work_path(wrong_work)
        }.to change(Work, :count).by(0)
        expect(response).to redirect_to root_url
      end
    end
  end
end
