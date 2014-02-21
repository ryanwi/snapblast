class TeamPhoneNumberCollector

  # Collect all phone numbers for a collection of rosters
  #
  # @param rosters
  #   Array of roster objects for a team
  #
  def self.collect(rosters)
    phone_numbers = []

    rosters.each do |roster|
      phone_numbers << roster_phone_numbers(roster)
      phone_numbers << contact_phone_numbers(roster)
    end

    # Flatten and only take unique numbers
    phone_numbers.flatten!
    phone_numbers.uniq!

    phone_numbers
  end

  # Find the player phone number(s) on the primary roster object
  #
  # @param roster
  #   Individual roster object
  #
  def self.roster_phone_numbers(roster)
    roster["roster"]["roster_telephone_numbers"].collect{|phone| phone["phone_number"]}
  end

  # Find the contact phone number(s) associated with a roster object
  #
  # @param rosters
  #   Individual roster object
  #
  def self.contact_phone_numbers(roster)
    phone_numbers = []

    roster["roster"]["contacts"].each do |contact|
      contact["contact_telephone_numbers"].each do |phone|
        phone_numbers << phone["phone_number"] unless phone["phone_number"].blank?
      end
    end

    phone_numbers
  end

end
