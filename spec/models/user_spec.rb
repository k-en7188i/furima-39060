require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'nicknameが6文字以下で登録できる' do
        @user.nickname = 'aaaaaa'
        @user.valid?
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        @user.valid?
        expect(@user).to be_valid
      end
    end
  end

  context '新規登録がうまくいかないとき' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'nicknameが7文字以上であれば登録できない' do
      @user.nickname = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 6 characters)')
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it '重複したemailが存在する場合登録できない' do
      @user.save
      user2 = FactoryBot.build(:user, email: @user.email)
      user2.valid?
      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailが無効な場合、登録できない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '英字のみのパスワードでは登録できない' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it '数字のみのパスワードでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it '全角文字を含むパスワードでは登録できない' do
      @user.password = 'パスワード1a'
      @user.password_confirmation = 'パスワード1a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
  end

  describe '本人情報確認' do
    context '本人情報確認がうまくいくとき' do
      it 'お名前(全角)は、漢字・ひらがな・カタカナでの入力ができる' do
        @user.last_name = '山田'
        @user.first_name = '太郎'
        @user.valid?
        expect(@user).to be_valid
      end

      it 'お名前カナ(全角)は、カタカナでの入力ができる' do
        @user.last_name_kana = 'ヤマダ'
        @user.first_name_kana = 'タロウ'
        @user.valid?
        expect(@user).to be_valid
      end
    end
    context '本人情報確認がうまくいかないとき' do
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

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'def'
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

      it '名字（フリガナ）は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it '名前は（フリガナ）は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it '生年月日が必須であること' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
