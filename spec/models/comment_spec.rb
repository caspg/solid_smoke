require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it "has valid factory" do
    expect(create(:comment)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:review) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:review_id) }
    it { should validate_presence_of(:content) }
    # validate_length_of doesn't work
    it { should ensure_length_of(:content).is_at_most(140) }
  end
end
