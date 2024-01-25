FactoryBot.define do
  factory :ticket do
    title { 'Amazing feature' }
    description { 'amazing description' }
    assigned_user_id { 1 }
    due_date { Date.today }
    status_id { Ticket.status_ids[:backlog] }
    progress { 50 }
  end
end
