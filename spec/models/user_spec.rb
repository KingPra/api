require "rails_helper"

RSpec.describe User, type: :model do
  describe "cred_steps" do
    it "has many cred steps upon initialization" do
      expect(subject.cred_steps).to_not be_empty
    end

    it "builds a cred step for every Credit in the db" do
      expect(Credit.count).to_not be_zero
      expect(subject.cred_steps.size).to eq(Credit.count)
    end

    it "builds unpersisted cred_steps" do
      expect(subject.cred_steps.all?(&:new_record?)).to eq(true)
    end
  end
end
