# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'IntegrationTest of Followings', type: :request do
  before do
    @test_user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:followed)
    log_in_as(@test_user)
  end

  describe 'Following page' do
    it 'is correctly displayed' do
      # フォロー一覧にアクセス
      # フォロー中のユーザーがないこと
      # レスポンスにフォロー中のアカウント数が含まれること
      # フォロー中のユーザーへのリンクが表示されていること
      get following_user_path(@test_user)
      expect(@test_user.following.empty?).to be_truthy
      expect(response.body).to match(
        %r{<strong[\S\s]*id="following"[\S\s]*>[\S\s]*#{@test_user.following.count}[\S\s]*</strong>}
      )
      @test_user.following.each do |user|
        expect(response.body).to match(
          /<a[\S\s]*href=#{user_path(user)}[\S\s]*>/
        )
      end
    end
  end

  describe 'Followers page' do
    it 'is correctly displayed' do
      # フォロワー一覧にアクセス
      # フォローされているユーザーがないこと
      # レスポンスにフォロワー数が含まれること
      # フォロワーのページへのリンクが表示されていること
      get followers_user_path(@test_user)
      expect(@test_user.followers.empty?).to be_truthy
      expect(response.body).to match(
        %r{<strong[\S\s]*id="followers"[\S\s]*>[\S\s]*#{@test_user.followers.count}[\S\s]*</strong>}
      )
      @test_user.followers.each do |user|
        expect(response.body).to match(
          /<a[\S\s]*href=#{user_path(user)}[\S\s]*>/
        )
      end
    end
  end

  describe 'Follow and unfollow button' do
    context 'in the standard way' do
      it 'works in follow action' do
        expect {
          post follow_relationships_path, params: { followed_id: @other_user.id }
        }.to change(@test_user.following, :count).by(1)
      end

      it 'works in unfollow action' do
        @test_user.follow(@other_user)
        relationship = @test_user.active_relationships.find_by(followed_id: @other_user.id)
        expect {
          delete follow_relationship_path(relationship)
        }.to change(@test_user.following, :count).by(-1)
      end
    end

    context 'with Ajax' do
      it 'works in follow action' do
        expect {
          post follow_relationships_path, xhr: true, params: { followed_id: @other_user.id }
        }.to change(@test_user.following, :count).by(1)
      end

      it 'works in unfollow action' do
        @test_user.follow(@other_user)
        relationship = @test_user.active_relationships.find_by(followed_id: @other_user.id)
        expect {
          delete follow_relationship_path(relationship), xhr: true
        }.to change(@test_user.following, :count).by(-1)
      end
    end
  end

  describe 'Feed on Home page' do
    it 'is displayed' do
      get root_path
      @test_user.feed.paginate(page: 1).each do |work|
        # expect(response.body).to match /#{CGI.escapeHTML(work.content)}/
        expect(response.body).to match(/#{CGI.escapeHTML(work.content)}/)
      end
    end
  end
end
