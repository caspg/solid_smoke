require 'rails_helper'

RSpec.describe Review, :type => :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:review)).to be_valid
  end

  describe "validations" do
    it "is not valid without title" do
      expect(build(:review, title: "")).not_to be_valid
    end
    it "is not valid without content" do
      expect(build(:review, content: "")).not_to be_valid
    end
    it "is not valid when content is to long" do
      expect(build(:review, content: "x" * 250)).not_to be_valid
    end
    it "is not valid when content is to short" do
      expect(build(:review, content: "xxxx")).not_to be_valid
    end
    it "is not valid without user_id" do
      expect(build(:review, user_id: "")).not_to be_valid
    end
    it "is not valid without movie_id" do
      expect(build(:review, movie_id: "")).not_to be_valid
    end
    it "dos not allow to write more than one revie for movie" do
      user = create(:user)
      movie = create(:movie)
      create(:review, user_id: user.id, movie_id: movie.id)
      expect(build(:review, user_id: user.id, movie_id: movie.id)).not_to be_valid
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:movie) }
  end
end
