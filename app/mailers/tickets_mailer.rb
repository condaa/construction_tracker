class TicketsMailer < ApplicationMailer
  
  def due_date_reminder(user_mail, ticket_title)
    mail({
      from: self.class.default[:from],
      to: user_mail,
      subject: "#{ticket_title} Ticket Due Date Reminder",
      body: 'This is a reminder that your ticket is due soon.'
    })
  end

end
