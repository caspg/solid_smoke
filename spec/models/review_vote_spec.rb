require 'rails_helper'

RSpec.describe ReviewVote, :type => :model do
  it "has valid factory" do
    expect(create(:review_vote)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:review) }
    it { should belong_to(:user) }
  end

  describe "validations" do
    subject do
      create(:review_vote)
    end

    it { should validate_uniqueness_of(:review_id).scoped_to(:user_id) }
    it { should validate_inclusion_of(:value).in_array([1, -1]) }

    it "is not valid when user is a review's author" do
      review = create(:review)
      expect(build(:review_vote, user_id: review.user_id, review_id: review.id)).not_to be_valid
    end
  end
end
