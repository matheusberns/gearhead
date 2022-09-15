# frozen_string_literal: true

class PermissionModuleTypeEnum < EnumerateIt::Base
  associate_values(
    post: 1,
    group: 2,
    department: 3,
    restaurant: 4,
    poll: 5,
    corporate_tv: 6,
    birthday_card: 7,
    contact: 8,
    shift: 9,
    headquarter: 10,
    user: 11,
    space: 12,
    useful_website: 13,
    benefit: 14,
    car: 15,
    category_attendance: 16,
    priority_attendance: 17,
    attendance: 18,
    solicitation: 19,
    account: 20,
    meeting_room: 21,
    table: 22,
    local: 23,
    company_birthday_card: 24,
    district: 25,
    digital_magazine: 26,
    visit: 27,
    scholarship: 28,
    calendar: 30,
    contract: 31,
    survey: 32,
    job_title: 33,
    employee_journey: 34,
    message_submission: 35
  )

  def self.name_ordered
    to_a
      .map { |name, id| { id: id, name: name } }
      .sort_by { |object| object[:name] }
  end

  sort_by :value
end
