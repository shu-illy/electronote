require 'rails_helper'

RSpec.describe "Works", type: :request do

  before do
    @work = FactoryBot.create(:work)
  end

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
          delete work_path(@work)
        }.to change(Work, :count).by(0)
        expect(response).to redirect_to login_url
      end
    end
  end
end
