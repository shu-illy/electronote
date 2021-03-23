# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UnitTest of follow_relationships controller', type: :request do
  describe 'Create action' do
    context 'without login' do
      # ログインなしでpostしても数が変わらないこと
      it 'does not increase follow_relationship count' do
        expect {
          post follow_relationships_path
        }.to change(FollowRelationship, :count).by(0)
      end
      # ログインなしでpostするとログインURLにリダイレクトされること
      it 'redirects to login URL' do
        post follow_relationships_path
        expect(response).to redirect_to login_url
      end
    end

    describe 'Destroy action' do
      let!(:test_follow) { FactoryBot.create(:follow_relationship) }
      context 'without login' do
        # ログインなしで削除しようとしても数が変わらないこと
        it 'does not decrease follow_relationship count' do
          expect {
            delete follow_relationship_path(test_follow)
          }.to change(FollowRelationship, :count).by(0)
        end
        # ログインなしで削除しようとするとログインURLにリダイレクトされること
        it 'redirects to login URL' do
          post follow_relationships_path
          expect(response).to redirect_to login_url
        end
      end
    end
  end
end
