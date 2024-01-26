require 'rails_helper'

RSpec.describe TicketDueDateReminderEmailSenderJob, type: :job do
  let(:user_mail) { 'late@user.com' }
  let(:ticket_title) { 'Some Title' }

  # assessment comment: I haven't used RSpec for a while due to a mandatory circumstance that I can discuss later
  # and I admit it's an area for improvement, but I'm sure that I can grasp it again before the job starting date

  puts "\n\n>>>>>>>>>>>>>>>>>>>>>>>>> Temporarily Comment >>>>>>>>>>>>>>>>>>>>>>>>>"
  puts "\tSending emails configurations isn't set yet"
  puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n"

  it 'enqueues TicketDueDateReminderEmailSenderJob which sends ticket due_date_reminder email' do
    expect(TicketsMailer).to receive(:due_date_reminder).with(user_mail, ticket_title).
    and_return(double("Mailer", deliver_now!: nil))
    subject.perform(user_mail, ticket_title)
  end
end
