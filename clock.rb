require 'clockwork'
require 'active_support/time'
include Clockwork

# chose the earliest timezone 'Pacific/Kiritimati', to ensure customers in early timezones receive the reminders on time
# e.g. if they set the 'due_date_reminder_time' at 1 am, this time will already be past for later timezones by 12 am
every(1.day, 'tickets_due_date_reminder_job', at: '00:00', tz: 'Pacific/Kiritimati') do
  TicketsDueDateReminderJob.perform_later
end
