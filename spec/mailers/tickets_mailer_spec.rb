require 'rails_helper'

RSpec.describe TicketsMailer, type: :mailer do

  describe 'due_date_reminder' do
    let(:user_mail) { 'late@user.com' }
    let(:ticket_title) { 'Sample Title' }

    it 'sends a due date reminder email' do
      mail = TicketsMailer.due_date_reminder(user_mail, ticket_title)
      expect(mail.subject).to eq("#{ticket_title} Ticket Due Date Reminder")
      expect(mail.to).to eq([user_mail])
      expect(mail.body.encoded).to include('This is a reminder that your ticket is due soon.')
    end
  end

end
