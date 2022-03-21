require 'rails_helper'

RSpec.describe PropertyCompany, type: :model do
  before do
    user = FactoryBot.create(:user)
    @property = FactoryBot.build(:property_company, user_id: user.id)
  end

  describe '物件/管理会社新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@property).to be_valid
      end
      it 'postal_codeは空でも登録できる' do
        @property.postal_code = ''
        expect(@property).to be_valid
      end
      it 'address_lineは空でも登録できる' do
        @property.address_line = ''
        expect(@property).to be_valid
      end
      it 'total_unitsは空でも登録できる' do
        @property.total_units = ''
        expect(@property).to be_valid
      end
      it 'building_yearは空でも登録できる' do
        @property.building_year = ''
        expect(@property).to be_valid
      end
      it 'building_areaは空でも登録できる' do
        @property.building_area = ''
        expect(@property).to be_valid
      end
      it 'land_areaは空でも登録できる' do
        @property.land_area = ''
        expect(@property).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'prefectureが空では登録できない' do
        @property.prefecture = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("都道府県を入力してください")
      end
      it 'cityが空では登録できない' do
        @property.city = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("市・区を入力してください")
      end
      it 'buildingが空では登録できない' do
        @property.building = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("物件名称を入力してください")
      end
      it 'business_entityが空では登録できない' do
        @property.business_entity = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("所有者を入力してください")
      end
      it 'purchase_dateが空では登録できない' do
        @property.purchase_date = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("購入年月を入力してください")
      end
      it 'postal_codeが3桁数値ハイフン4桁数値の形式でないと登録できない' do
        @property.postal_code = '1112222'
        @property.valid?
        expect(@property.errors.full_messages).to include("郵便番号は###-####（半角）の形式で入力してください")
      end
      it 'postal_codeが全角では登録できない' do
        @property.postal_code = '１１１-２２２２'
        @property.valid?
        expect(@property.errors.full_messages).to include("郵便番号は###-####（半角）の形式で入力してください")
      end
      it 'telephoneが10桁未満の数値では登録できない' do
        @property.telephone = '123456789'
        @property.valid?
        expect(@property.errors.full_messages).to include("電話番号は10~11桁の半角数字で入力してください")
      end
      it 'telephoneが12桁以上の数値では登録できない' do
        @property.telephone = '123456789012'
        @property.valid?
        expect(@property.errors.full_messages).to include("電話番号は10~11桁の半角数字で入力してください")
      end
      it 'telephoneが全角では登録できない' do
        @property.telephone = '１２３４５６７８９０'
        @property.valid?
        expect(@property.errors.full_messages).to include("電話番号は10~11桁の半角数字で入力してください")
      end
      it 'telephoneにハイフンが入っていては登録できない' do
        @property.telephone = '123-456-789'
        @property.valid?
        expect(@property.errors.full_messages).to include("電話番号は10~11桁の半角数字で入力してください")
      end
      it 'telephoneは半角英数字混合では登録できない' do
        @property.telephone = 'abcde12345'
        @property.valid?
        expect(@property.errors.full_messages).to include("電話番号は10~11桁の半角数字で入力してください")
      end
      it 'userが紐付いていないと登録できない' do
        @property.user_id = nil
        @property.valid?
        expect(@property.errors.full_messages).to include("Userを入力してください")
      end
      it 'emailに@が含まれない場合登録できない' do
        @property.email = 'testtest'
        @property.valid?
        expect(@property.errors.full_messages).to include("メールアドレスは有効なメールアドレス形式で入力してください")
      end
      it 'total_unitsが全角では登録できない' do
        @property.total_units = '１２３'
        @property.valid?
        expect(@property.errors.full_messages).to include("総戸数は1以上の半角整数で入力してください")
      end
      it 'total_unitsが文字では登録できない' do
        @property.total_units = 'a'
        @property.valid?
        expect(@property.errors.full_messages).to include("総戸数は1以上の半角整数で入力してください")
      end
      it 'departmentが空でないとき、管理会社が空では登録できない' do
        @property.name = ''
        @property.department = 'a'
        @property.sales_person = ''
        @property.telephone = ''
        @property.email = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("管理会社を入力してください")
      end
      it 'sales_personが空でないとき、管理会社が空では登録できない' do
        @property.name = ''
        @property.department = ''
        @property.sales_person = '山田'
        @property.telephone = ''
        @property.email = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("管理会社を入力してください")
      end
      it 'telephoneが空でないとき、管理会社が空では登録できない' do
        @property.name = ''
        @property.department = ''
        @property.sales_person = ''
        @property.telephone = '09012345678'
        @property.email = ''
        @property.valid?
        expect(@property.errors.full_messages).to include("管理会社を入力してください")
      end
      it 'emailが空でないとき、管理会社が空では登録できない' do
        @property.name = ''
        @property.department = ''
        @property.sales_person = ''
        @property.telephone = ''
        @property.email = 'email@email'
        @property.valid?
        expect(@property.errors.full_messages).to include("管理会社を入力してください")
      end
    end
  end
end
