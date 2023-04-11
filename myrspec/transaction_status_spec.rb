require 'rails_helper'

RSpec.describe TransactionStatus, type: :model do
  describe "associations" do
    it { should have_many(:transactions) }
  end

  describe "scopes" do
    describe ".map_id_with_name" do
      let!(:status1) { create(:transaction_status, name: "Status1") }
      let!(:status2) { create(:transaction_status, name: "Status2") }

      it "returns a hash of status names and ids" do
        expect(TransactionStatus.map_id_with_name).to eq([["Status1", status1.id], ["Status2", status2.id]])
      end
    end

    describe ".map_slug_with_name" do
      let!(:status1) { create(:transaction_status, name: "Status1") }
      let!(:status2) { create(:transaction_status, name: "Status2") }

      it "returns a hash of status names and slugs" do
        expect(TransactionStatus.map_slug_with_name).to eq([["Status1", status1.slug], ["Status2", status2.slug]])
      end
    end
  end

end
