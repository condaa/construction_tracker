FactoryBot.define do
  sequence :uniqe_mail do |n|
    "ahmed#{n}@salah.com"
  end

  factory :user do
    name { 'Ahmed Salah' }
    mail { generate(:uniqe_mail) }
    send_due_date_reminder { false }
    due_date_reminder_interval { 0 }
    due_date_reminder_time { '12:00' }
    time_zone { 'UTC' }
  end
end
