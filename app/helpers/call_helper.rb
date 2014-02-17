module CallHelper
  def has_number(roster)
    contact_phones = contact_phone_array(roster)
    return "no_number" if roster["roster"]["roster_telephone_numbers"].empty? && contact_phones.empty?
  end

  def format_numbers(roster)
    return '<span style="font-style: italic;">No Phone Number Provided</span>'.html_safe if roster["roster"]["roster_telephone_numbers"].empty?

    phones = []
    roster["roster"]["roster_telephone_numbers"].each do |phone|
      phone_label = phone["label"]
      phone_number = phone["phone_number"]
      phones.push phone_label.blank? ? phone_number : "#{phone_label} : #{phone_number}"
    end
    contact_phone_array(roster).each do |phone|
      phone_label = phone[1]["label"]
      phone_number = phone[1]["phone_number"]
      contact_name = phone[0]["first"] + " " + phone[0]["last"]
      phone_string = phone_label.blank? ? phone_number : "#{phone_label} : #{phone_number}"
      phone_string = phone_string + " (#{contact_name})" unless contact_name.blank?
      phones.push phone_string
    end
    phones.join(', ')
  end

  private

  def contact_phone_array(roster)
    contact_phones = []
    roster["roster"]["contacts"].each do |contact|
      contact["contact_telephone_numbers"].each do |phone|
        contact_phones.push [contact, phone]
      end
    end
    contact_phones
  end
end
