# frozen_string_literal: true

# == Schema Information
#
# Table name: follow_relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint
#  follower_id :bigint
#
# Indexes
#
#  index_follow_relationships_on_followed_id                  (followed_id)
#  index_follow_relationships_on_follower_id                  (follower_id)
#  index_follow_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
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
