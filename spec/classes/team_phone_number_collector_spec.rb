require 'spec_helper'

describe TeamPhoneNumberCollector do

  describe "#collect" do

    it "returns numbers from rosters, no contacts" do
      rosters = JSON.parse load_sample('teamsnap/rosters.json')
      phone_numbers = TeamPhoneNumberCollector.collect rosters
      phone_numbers.should have(1).items
    end

    it "returns numbers from rosters and the contacts of each roster" do
      rosters = JSON.parse load_sample('teamsnap/rosters_with_contacts.json')
      phone_numbers = TeamPhoneNumberCollector.collect rosters
      phone_numbers.should have(5).items
    end

  end

end
