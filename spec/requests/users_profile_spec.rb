require 'rails_helper'

RSpec.describe "IntegrationTest of UsersProfile", type: :request do
  
  before do
    @user = FactoryBot.create(:user)
  end

  describe "User profile" do
    it "display" do
      31.times do |n|
        title  = "circuit#{n+1}"
        description = "test#{n+1}"
        FactoryBot.create(:work, :day_before_yesterday, title: title, description: description, user: @user)
      end
      get user_path(@user)
      expect(response).to render_template "users/show"
      expect(response.body).to include "<title>#{full_title(@user.name)}"
      expect(response.body).to match /<h1>[\S\s]*<img alt=\"#{full_title(@user.name)}[\S\s]*<\/h1>/
      expect(response.body).to match /<h1>[\S\s]*<img[\S\s]*class=\"gravatar\"[^>]*>[\S\s]*<\/h1>/
      expect(response.body).to match @user.works.count.to_s
      expect(response.body).to match /<ul[^>]*class=\"pagination\"[^>]*>/
      @user.works.paginate(page: 1).each do |work|
        expect(response.body).to match work.title
      end
    end
  end
end
