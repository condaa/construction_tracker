FactoryBot.define do
  factory :ticket do
    title { 'Amazing feature' }
    description { 'amazing description' }
    assigned_user_id { User.first }
    due_date { Date.today + 3 }
    status_id { Ticket.status_ids[:backlog] }
    progress { 90 }
  end
end
