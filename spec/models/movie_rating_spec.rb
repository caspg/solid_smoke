require 'rails_helper'

RSpec.describe MovieRating, type: :model do
  it 'has valid factory' do
    expect(create(:movie_rating)).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end

  describe 'validations' do
    subject do
      create(:movie_rating)
    end

    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:movie) }
    it { should validate_inclusion_of(:score).in_range(1..5) }
    it { should validate_uniqueness_of(:movie_id).scoped_to(:user_id) }
  end
end
