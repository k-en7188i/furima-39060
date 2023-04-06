require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    before do
      @user = User.new(
        nickname: 'test',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        last_name: '山田',
        first_name: '太郎',
        last_name_kana: 'ヤマダ',
        first_name_kana: 'タロウ',
        birth_date: Date.new(2000, 1, 1)
      )
    end

    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であると登録できること' do
      user1 = FactoryBot.build(:user, last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ',
                                      birth_date: '2000-01-01', email: 'test@example.com')
      user1.save
      user2 = FactoryBot.build(:user, email: 'test@example.com')
      user2.valid?
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password = 'password123'
      @user.password_confirmation = 'password456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do
    before do
      @user = FactoryBot.build(:user, last_name: '山田', first_name: '太郎')
      # @user = FactoryBot.build(:user)
    end

    it 'お名前(全角)は、名字が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'お名前(全角)は、名前が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'お名前(全角)は、全角（漢字）での入力ができる' do
      @user.last_name = '山田'
      @user.first_name = '太郎'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'お名前(全角)は、全角（ひらがな）での入力ができる' do
      @user.last_name = 'やまだ'
      @user.first_name = 'たろう'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'お名前(全角)は、全角（カタカナ）での入力ができる' do
      @user.last_name = 'ヤマダ'
      @user.first_name = 'タロウ'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'last_name(全角)は、全角（漢字・ひらがな・カタカナ）での入力がであること' do
      @user.last_name = 'yes'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_name(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'no'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'last_name(全角)は、全角（ひらがな）での入力がであること' do
      @user.last_name = 'yes'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_name(全角)は、全角（ひらがな）での入力が必須であること' do
      @user.first_name = 'no'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'お名前カナ(全角)は、名字が必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'お名前カナ(全角)は、名前が必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      @user.last_name_kana = 'やまだ'
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid', 'First name kana is invalid')
    end

    it '生年月日が必須であること' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
