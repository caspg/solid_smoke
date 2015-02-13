class CreateReviewVotes < ActiveRecord::Migration
  def change
    create_table :review_votes do |t|
      t.integer :review_id
      t.integer :user_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
