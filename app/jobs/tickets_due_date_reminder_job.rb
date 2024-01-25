class TicketsDueDateReminderJob < ApplicationJob
  queue_as :default

  def perform
    to_be_reminded_users.find_each{ |user|
      user.tickets.each{ |ticket|
        send_due_date_reminder(user, ticket)
      }
    }
  end

  private

  # users with 'send_due_date_reminder' enabled
  # who have tickets to be reminded of today according to their preferred 'due_date_reminder_interval' date
  def to_be_reminded_users
    User.with_due_date_reminder.
    includes(:tickets).
    joins(:tickets).
    merge(Ticket.with_remindable_status).
    where("tickets.due_date = date('#{earliest_tz_today_date}') + users.due_date_reminder_interval")
  end

  # send a due date reminder through the user's preferred medium
  def send_due_date_reminder(user, ticket)
    # only mail for now
    send_due_date_reminder_email(user, ticket)
  end

  def send_due_date_reminder_email(user, ticket)
    # assessment comment:
    # just for the sake of POC, I assume only user's mail and ticket's title are needed
    # instead of sending IDs then fetching the 2 records from the DB later
    # since we know it's better to pass minimal data when enqueueing background jobs instead of passing the full objects
    TicketDueDateReminderEmailSenderJob.perform_later(user.mail, ticket.title)
  end

  def earliest_tz_today_date
    ActiveSupport::TimeZone['Pacific/Kiritimati'].now.to_date
  end
end
