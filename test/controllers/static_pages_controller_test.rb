require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "ElectroNote"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | ElectroNote"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | ElectroNote"
  end

end
