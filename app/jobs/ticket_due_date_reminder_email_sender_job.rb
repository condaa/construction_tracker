class TicketDueDateReminderEmailSenderJob < ApplicationJob
  queue_as :default

  # assessment comment:
  # just for the sake of POC, I assume only user's mail and ticket's title are needed
  # instead of sending IDs then fetching the 2 records from the DB later
  # since we know it's better to pass minimal data when enqueueing background jobs instead of passing the full objects
  def perform(user_mail, ticket_title)
    TicketsMailer.due_date_reminder(user_mail, ticket_title).deliver_now!
  end

end
