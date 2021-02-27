require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
  # describe "GET /site_layouts" do
  #   it "works! (now write some real specs)" do
  #     get site_layouts_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  describe "GET root_path" do
    it "display Top Page" do
      expect().to
    end
  end

  # test "layout links" do
  #   get root_path
  #   assert_template 'static_pages/top'
  #   assert_select "a[href=?]", root_path, count: 2
  #   assert_select "a[href=?]", help_path
  #   assert_select "a[href=?]", contact_path
  #   assert_select "a[href=?]", signup_path
  #   get contact_path
  #   assert_select "title", full_title("Contact")
  #   get help_path
  #   assert_select "title", full_title("Help")
  # end
end
