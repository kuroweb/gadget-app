require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "バリデーションテスト" do
    subject(:comment) { create(:comment) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:description)}
    it { is_expected.to validate_length_of(:description)}
  end
  
  describe "アソシエーションテスト" do
    subject(:comment) { create(:comment) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
  
end
