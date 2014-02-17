require "spec_helper"

describe CallHelper do

  before :all do
    @rosters = JSON.parse load_sample('teamsnap/rosters.json')
  end

  describe "#has_number" do
    it "returns no_number when roster has no phone number" do
      roster_without_phone = @rosters.select{ |r| r["roster"]["roster_telephone_numbers"].empty? }.first
      expect(helper.has_number(roster_without_phone)).to eq("no_number")
    end

    it "returns blank when roster has a phone number" do
      roster_with_phone = @rosters.select{ |r| !r["roster"]["roster_telephone_numbers"].empty? }.first
      expect(helper.has_number(roster_with_phone)).to be_nil
    end
  end

  describe "#format_numbers" do
    it "returns no number message when roster has no phone number" do
      roster_without_phone = @rosters.select{ |r| r["roster"]["roster_telephone_numbers"].empty? }.first
      expect(helper.format_numbers(roster_without_phone)).to eq("<span style=\"font-style: italic;\">No Phone Number Provided</span>")
    end

    it "returns label and number for a roster with a single phone number" do
      single_phone = @rosters.select{ |r| !r["roster"]["roster_telephone_numbers"].empty? }.first
      expect(helper.format_numbers(single_phone)).to eq("Mobile : 5555555555")
    end

    it "returns number with no label" do
      pending("gather sample response for roster with a number wihtout a label")
    end

    it "returns multiple numbers formatted" do
      pending("gather sample response for roster with multiple numbers")
    end

  end
end
