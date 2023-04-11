require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  subject(:expense_category) { build(:expense_category) }

  describe 'associations' do
    it { is_expected.to belong_to(:user_category).optional }
    it { is_expected.to have_many(:sub_categories).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'callbacks' do
    it 'capitalizes the first letter of name before saving' do
      expense_category.name = 'food'
      expense_category.save
      expect(expense_category.name).to eq('Food')
    end
  end

  describe 'scopes' do
    describe '.map_id_with_name' do
      let!(:expense_category_1) { create(:expense_category, name: 'Groceries') }
      let!(:expense_category_2) { create(:expense_category, name: 'Entertainment') }
      let!(:expense_category_3) { create(:expense_category, name: 'Travel') }

      it 'returns an array of expense category names and ids' do
        expect(described_class.map_id_with_name).to contain_exactly(
          ['Entertainment', expense_category_2.id],
          ['Groceries', expense_category_1.id],
          ['Travel', expense_category_3.id]
        )
      end
    end
  end

end
