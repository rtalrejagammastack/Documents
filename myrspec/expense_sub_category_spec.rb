require 'rails_helper'

RSpec.describe ExpenseSubCategory, type: :model do
  let(:category) { create(:expense_category) }

  describe 'associations' do
    it { should belong_to(:category).class_name('ExpenseCategory') }
    it { should belong_to(:user_category).optional }
    it { should have_many(:transactions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'callbacks' do
    describe '#capital_first_letter' do
      let(:sub_category) { build(:expense_sub_category, name: 'food') }

      it 'capitalizes the first letter of name before saving' do
        sub_category.save
        expect(sub_category.name).to eq('Food')
      end
    end
  end

  describe 'scopes' do
    describe '.default_scope' do
      it 'orders sub-categories by name ascending' do
        sub_category1 = create(:expense_sub_category, category: category, name: 'Groceries')
        sub_category2 = create(:expense_sub_category, category: category, name: 'Restaurants')
        expect(ExpenseSubCategory.all).to eq([sub_category2, sub_category1])
      end
    end
  end
end
