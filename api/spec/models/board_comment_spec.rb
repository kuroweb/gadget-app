require 'rails_helper'

RSpec.describe BoardComment, type: :model do
  describe "バリデーションテスト" do
    subject(:board_comment) { create(:board_comment) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:description)}
    it { is_expected.to validate_length_of(:description)}
  end
  
  describe "アソシエーションテスト" do
    subject(:board_comment) { create(:board_comment) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:board) }
  end

end
