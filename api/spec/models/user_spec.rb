require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'バリデーションテスト' do
    context 'ユーザー作成時' do
      subject(:user) { create(:user) }
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:uid) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_length_of(:email) }

      it 'uid, name, emailの値が設定済みだと成功' do
        user = build(:user)
        expect(user).to be_valid
      end
      it 'uid, name, emailの値が未設定だと失敗' do
        user = build(:user)
        user.uid = ''
        user.name = ''
        user.email = ''
        expect(user).to_not be_valid
      end
      it 'uid, emailの値がユニークだと成功' do
        user_1 = create(:user)
        user_2 = build(:user)
        expect(user_2).to be_valid
      end
      it 'uid, emailの値がユニークでないと失敗' do
        user_1 = create(:user)
        user_2 = build(:user)
        user_2.uid = user_1.uid
        user_2.email = user_1.email
        expect(user_2).to_not be_valid  
      end
    end

    context 'Userモデル更新時' do
      it 'profileの文字数が255以下だと成功' do
        user = build(:user)
        user.profile = "255以下"
        expect(user).to be_valid
      end
      it 'profileの文字数が255以上だと失敗' do
        user = build(:user)
        profile = "255以上" * 255
        user.profile = profile
        expect(user).to_not be_valid
      end
    end
  end

  describe "アソシエーションテスト" do
    subject(:user) { create(:user)}
    it { is_expected.to have_many(:active_relationships) }
    it { is_expected.to have_many(:passive_relationships) }
    it { is_expected.to have_many(:following) }
    it { is_expected.to have_many(:followers) }
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liked_posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:boards) }
    it { is_expected.to have_many(:board_comments) }
    it { is_expected.to have_many(:user_tag_maps) }
    it { is_expected.to have_many(:tags) }
  end
end
