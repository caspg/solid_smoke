require 'rails_helper'

RSpec.describe Movie, :type => :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:movie)).to be_valid
  end

  describe  "validations" do 
    it "is not valid without title" do
      expect(build(:movie, title: "")).not_to be_valid
    end
    it "is not valid without year" do
      expect(build(:movie, year: "")).not_to be_valid
    end
    it "is not valid without plot" do
      expect(build(:movie, plot: "")).not_to be_valid
    end
    it "is not valid when plot is too long" do
      expect(build(:movie, plot: "x" * 1500)).not_to be_valid
    end
    it "is not valid when plot is too short" do
      expect(build(:movie, plot: "x" * 10)).not_to be_valid
    end
    it "is not valid without user_id" do
      expect(build(:movie, user_id: "")).not_to be_valid
    end
    it "does not allow duplicate of title within one year" do
      create(:movie)
      expect(build(:movie)).not_to be_valid
    end
    it "does allow duplicate of title when year is different" do
      create(:movie)
      expect(build(:movie, year: "1915")).to be_valid
    end
  end

  describe "associations" do
    it { should have_many(:reviews).dependent(:destroy) }
  end

  describe '#rating_average and #rating_count' do
    let(:user)  { create(:user) }
    let(:user2) { create(:user) }
    let(:movie) { create(:movie) }
    let(:movie_rating)  {create(:movie_rating, score: 2, user: user,  movie: movie) }
    let(:movie_rating2) {create(:movie_rating, score: 4, user: user2, movie: movie) }

    before do
      movie.movie_ratings << [movie_rating, movie_rating2]
    end

    it 'calculates averate rating' do
      expect(movie.rating_average).to eq(3)
    end

    it 'calculates number of votes' do
      expect(movie.rating_count).to eq(2)
    end
  end

  describe 'papeclip' do
    it { should have_attached_file(:poster) }
    it { should validate_attachment_content_type(:poster).
            allowing('image/png', 'image/jpeg').
            rejecting('text/plain', 'text/xml') }
    it { should validate_attachment_size(:poster).less_than(1.megabytes) }
  end
end
