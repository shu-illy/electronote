# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UnitTest of sessions controller', type: :request do
  describe 'GET login_path' do
    it 'returns success' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
  # describe "GET /new" do
  #   it "returns http success" do
  #     get "/sessions/new"
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
