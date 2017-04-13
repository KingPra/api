require "rails_helper"

RSpec.describe CreateEvent do
  subject(:result) { described_class.call(some_context) }
  let(:event) { build(:event) }
  let(:some_context) do
    { event: event }
  end
  let(:validator_str) { "Validate#{event.category}".classify }
  let(:validator_double) { double(:validator_double) }
  let(:success) { true }
  let(:validator_result) do
    double(:context, success?: success, errors: {})
  end

  before do
    allow(validator_double).to receive(:call).and_return(validator_result)
  end

  it "executes a validator if it exists" do
    stub_const(validator_str, validator_double)

    expect(validator_double).to receive(:call)
    result
  end

  it "doesn't blow up if a validator does NOT exist" do
    expect { result }.to_not raise_error
  end

  context "when a validator fails" do
    let(:success) { false }

    it "fails execution" do
      stub_const(validator_str, validator_double)

      expect(result).to be_a_failure
      expect(result.errors).to eq(validator_result.errors)
    end
  end
end
