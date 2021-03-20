# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UnitTest of static_pages controller', type: :request do
  let(:base_title) { 'ElectroNote' }

  describe 'GET root_path' do
    before do
      get root_path
    end

    # GET root_pathのレスポンスがsuccessであること
    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    # root_pathのタイトルが正しいこと
    it 'have appropriate title' do
      expect(response.body).to include "<title>#{base_title}</title>"
    end
  end

  describe 'GET contact_path' do
    before do
      get contact_path
    end

    # GET contact_pathのレスポンスがsuccessであること
    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    # contact_pathのタイトルが正しいこと
    it 'have appropriate title' do
      expect(response.body).to include "<title>Contact | #{base_title}</title>"
    end
  end

  describe 'GET help_path' do
    before do
      get help_path
    end

    # GET help_pathのレスポンスがsuccessであること
    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    # help_pathのタイトルが正しいこと
    it 'have appropriate title' do
      expect(response.body).to include "<title>Help | #{base_title}</title>"
    end
  end
end
