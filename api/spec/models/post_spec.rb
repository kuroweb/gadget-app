require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "バリデーションテスト" do
    context "投稿作成時" do
      subject(:post) { create(:post) }

      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:description)}
      it { is_expected.to validate_length_of(:description)}
    end
  end

  describe "アソシエーションテスト" do
    subject(:post) { create(:post) }
    
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:post_tag_maps) }
    it { is_expected.to have_many(:tags) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liked_users) }
    it { is_expected.to have_many(:post_comments) }
  end

end
