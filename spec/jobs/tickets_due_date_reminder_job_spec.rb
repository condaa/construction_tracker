require 'rails_helper'

RSpec.describe TicketsDueDateReminderJob, type: :job do
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket, assigned_user: user) }

  it 'sends due date reminders to users with tickets to be reminded' do
    allow(User).to receive(:with_due_date_reminder).and_return(User)
    allow(User).to receive_message_chain(:includes, :joins, :merge, :where).and_return(User)

    expect(Ticket).to receive(:with_remindable_status).and_return(ticket)
    expect(Ticket).to receive(:find_each).and_yield(ticket)
    expect(subject).to receive(:send_due_date_reminder).with(user, ticket)

    subject.perform
  end
end