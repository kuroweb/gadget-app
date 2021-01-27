require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe "バリデーションテスト" do
    subject(:tag) { create(:tag) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:tag_name) }
    it { is_expected.to validate_length_of(:tag_name) }
  end
  
  describe "アソシエーションテスト" do
    subject(:tag) { create(:tag) }

    it { is_expected.to have_many(:post_tag_maps)}
    it { is_expected.to have_many(:posts)}
    it { is_expected.to have_many(:board_tag_maps)}
    it { is_expected.to have_many(:boards)}
    it { is_expected.to have_many(:user_tag_maps)}
    it { is_expected.to have_many(:users)}
    it { is_expected.to have_many(:gadget_tag_maps)}
    it { is_expected.to have_many(:gadgets)}
  end
  
end
