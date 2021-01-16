require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "バリデーションテスト" do
    context "掲示板作成時" do
      subject(:board) { create(:board) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:description)}
      it { is_expected.to validate_length_of(:description)}
      it { is_expected.to validate_presence_of(:title)}
      it { is_expected.to validate_length_of(:title)}
      it { is_expected.to validate_presence_of(:board_type)}
    end
    
  end
  
  describe "アソシエーションテスト" do
    subject(:board) { create(:board) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:board_comments) }
    it { is_expected.to have_many(:board_tag_maps) }
    it { is_expected.to have_many(:tags) }
  end
  
end
