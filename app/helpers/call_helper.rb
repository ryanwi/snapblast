module CallHelper
  def has_number(roster)
    return "no_number" if roster["roster"]["roster_telephone_numbers"].empty?
  end

  def format_numbers(roster)
    return '<span style="font-style: italic;">No Phone Number Provided</span>'.html_safe if roster["roster"]["roster_telephone_numbers"].empty?

    phones = []
    roster["roster"]["roster_telephone_numbers"].each do |phone|
      phone_label = phone["label"]
      phone_number = phone["phone_number"]
      phones.push phone_label.blank? ? phone_number : "#{phone_label} : #{phone_number}"
    end
    phones.join(', ')
  end
end
