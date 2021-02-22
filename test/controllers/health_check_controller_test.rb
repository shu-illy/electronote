require 'test_helper'

class HealthCheckControllerTest < ActionDispatch::IntegrationTest
  test "should get health" do
    get healthcheck_path
    assert_response :success
  end
end
