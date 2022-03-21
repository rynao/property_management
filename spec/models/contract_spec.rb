require 'rails_helper'

RSpec.describe Contract, type: :model do
  before do
    @contract = FactoryBot.build(:contract)
  end

  describe '契約新規登録' do
    context '新規登録できるとき' do
      it '全ての項目が存在すれば登録できる' do
        expect(@contract).to be_valid
      end
      it 'contractorは空でも登録できる' do
        @contract.contractor = ''
        expect(@contract).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'start_dateが空では登録できない' do
        @contract.start_date = ''
        @contract.valid?
        expect(@contract.errors.full_messages).to include("契約開始日を入力してください")
      end
      it 'end_dateが空では登録できない' do
        @contract.end_date = ''
        @contract.valid?
        expect(@contract.errors.full_messages).to include("契約終了日を入力してください")
      end
      it 'rentが空では登録できない' do
        @contract.rent = ''
        @contract.valid?
        expect(@contract.errors.full_messages).to include("家賃は1以上の半角整数で入力してください")
      end
      it 'management_costが空では登録できない' do
        @contract.management_cost = ''
        @contract.valid?
        expect(@contract.errors.full_messages).to include("管理費は数値で入力してください")
      end
      it 'userが紐付いていないと登録できない' do
        @contract.user = nil
        @contract.valid?
        expect(@contract.errors.full_messages).to include("Userを入力してください")
      end
      it 'propertyが紐付いていないと登録できない' do
        @contract.property = nil
        @contract.valid?
        expect(@contract.errors.full_messages).to include("Propertyを入力してください")
      end
      it 'roomが紐付いていないと登録できない' do
        @contract.room = nil
        @contract.valid?
        expect(@contract.errors.full_messages).to include("Roomを入力してください")
      end
    end
  end
end
