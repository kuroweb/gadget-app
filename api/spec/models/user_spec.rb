require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデル作成時のバリデーションテスト' do
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

  describe 'Userモデル更新時のバリデーションテスト' do
    it 'profileの文字数が255以下だと成功' do
      user = build(:user)
      user.profile = "255以下"
      expect(user).to be_valid
    end
  end


end
