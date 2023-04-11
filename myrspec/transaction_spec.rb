require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "associations" do
    it { should belong_to(:user_category) }
    it { should belong_to(:expense_sub_category) }
    it { should belong_to(:status).class_name('TransactionStatus') }
    it { should belong_to(:type).class_name('TransactionType') }
    it { should belong_to(:mode).class_name('TransactionMode') }
    it { should belong_to(:payee).class_name('User').optional }
    it { should belong_to(:payer).class_name('User').optional }
    it { should have_many_attached(:documents).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:amount) }
  end

  describe "scopes" do
    describe ".create_hash_transactions_group_by_date" do
      it "groups transactions by date" do
        user_category = create(:user_category)
        expense_sub_category = create(:expense_sub_category)
        transaction = create(:transaction, user_category: user_category, expense_sub_category: expense_sub_category)
        result = Transaction.create_hash_transactions_group_by_date
        expect(result.keys).to include(transaction.created_at.to_date)
      end
    end
  end

  describe "class methods" do
    describe ".ransackable_attributes" do
      it "returns an array of ransackable attributes" do
        expect(Transaction.ransackable_attributes).to include("amount", "created_at", "description", "destroyed_at", "expense_sub_category_id", "id", "mode_id", "payee_id", "payee_name", "payer_id", "payer_name", "slug", "status_id", "type_id", "updated_at", "user_category_id")
      end
    end

    describe ".ransackable_associations" do
      it "returns an array of ransackable associations" do
        expect(Transaction.ransackable_associations).to include("payee", "payer")
      end
    end
  end
end
