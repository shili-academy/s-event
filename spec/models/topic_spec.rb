require 'rails_helper'

RSpec.describe Topic, type: :model do
  let!(:topic) {FactoryBot.create(:topic)}

  describe "associations" do
    it "has_many events" do
      t = Topic.reflect_on_association(:events)
      expect(t.macro).to eq(:has_many)
    end
    it "has_many tasks" do
      t = Topic.reflect_on_association(:tasks)
      expect(t.macro).to eq(:has_many)
    end
  end
end
