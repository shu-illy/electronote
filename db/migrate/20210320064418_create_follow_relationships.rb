# frozen_string_literal: true

class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.bigint :follower_id
      t.bigint :followed_id

      t.timestamps
    end
    add_index :follow_relationships, :follower_id
    add_index :follow_relationships, :followed_id
    add_index :follow_relationships, [:follower_id, :followed_id], unique: true
  end
end
