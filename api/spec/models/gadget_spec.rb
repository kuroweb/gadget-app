require 'rails_helper'

RSpec.describe Gadget, type: :model do

  describe "バリデーションテスト" do
    context "ガジェット作成時" do
      subject(:gadget) { create(:gadget) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:title)}
      it { is_expected.to validate_length_of(:title)}
      it { is_expected.to validate_presence_of(:good_description)}
      it { is_expected.to validate_length_of(:good_description)}
      it { is_expected.to validate_presence_of(:bad_description)}
      it { is_expected.to validate_length_of(:bad_description)}
      it { is_expected.to validate_presence_of(:stars)}
    end
  end

  describe "アソシエーションテスト" do
    subject(:gadget) { create(:gadget) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:gadget_tag_maps) }
    it { is_expected.to have_many(:tags) }
  end

end
