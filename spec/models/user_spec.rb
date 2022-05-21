require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {FactoryBot.create(:user)}

  describe "validates" do
    it "name is presence" do
      record = User.new(first_name: "")
      record.validate
      expect(record.errors[:first_name]).to include("không thể để trắng")
    end

    it "name is presence" do
      record = User.new(last_name: "")
      record.validate
      expect(record.errors[:last_name]).to include("không thể để trắng")
    end
  end

  describe "associations" do
    it "has_many events" do
      t = User.reflect_on_association(:events)
      expect(t.macro).to eq(:has_many)
    end
    it "has_many tasks" do
      t = User.reflect_on_association(:tasks)
      expect(t.macro).to eq(:has_many)
    end
  end

  describe "method" do
    it "have method full_name" do
      full_name = user.first_name + " " + user.last_name
      expect(user.full_name).to eq full_name
    end
  end
end
