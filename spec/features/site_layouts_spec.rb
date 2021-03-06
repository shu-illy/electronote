require 'rails_helper'

RSpec.describe "IntegrationTest of SiteLayout", type: :feature do

  scenario "layout links" do
    visit root_path
    expect(page).to have_link nil, href: root_path, count: 2
    expect(page).to have_link nil, href: help_path
    expect(page).to have_link nil, href: contact_path
    visit contact_path
    expect(page).to have_title full_title("Contact")
    visit signup_path
    expect(page).to have_title full_title("新規登録")
  end
      
end
