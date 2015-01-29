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
end
