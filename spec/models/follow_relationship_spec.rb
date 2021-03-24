# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  let!(:followed) { FactoryBot.create(:followed) }
  let!(:follower) { FactoryBot.create(:follower) }
  let!(:test_follow) { FactoryBot.build(:follow_relationship, follower_id: follower.id, followed_id: followed.id) }
  # let!(:test_follow) { FollowRelationship.new(follower_id: follower.id, followed_id: followed.id) }

  describe FollowRelationship do
    it 'is valid' do
      expect(test_follow).to be_valid
    end

    it 'requires a follower_id' do
      test_follow.follower_id = nil
      expect(test_follow).to be_invalid
    end

    it 'requires a followed_id' do
      test_follow.followed_id = nil
      expect(test_follow).to be_invalid
    end
  end
end
