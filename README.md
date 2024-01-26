# README

Application description:

  Ruby on Rails only-APIs app for construction documentation & defect management
  users create many tickets daily which are usually created to report a defect and it is assigned to a project member to fix it

Dependencies installation:

  Rails 7.1.3 with Ruby 3.2.2
  PostgreSQL 14.10 (client and server)
  Redis 7.0.11 (client and server)

Gems installation:

  bundle install

Database creation:

  rails db:create

Database migration:

  rails db:migrate

Test suite running:

  rspec

Scheduling jobs library running:

  bundle exec clockwork clock.rb

Background jobs library running:

  bundle exec sidekiq

Main application goal:

  Remind the users with the unfinished tickets on their preferred time

How it works:

  a self-triggered job is run every midnight (at earliest time zone, more details in the code) to check if there are
  users to be reminded of their remindable tickets
  it selects the preferred user medium to be reminded on (only emails so far)
  it enqueues a background job for each reminder to be run on the preffered user time

What is in the Application:
  01. users table migration
  02. User model
  03. users factory
  04. user spec
  05. tickets table migration
  06. Ticket model
  07. tickets factory
  08. ticket spec
  09. added more 5 needed gems ('rspec-rails', 'shoulda-matchers', 'factory_bot_rails', 'clockwork' & 'sidekiq')
  10. the 5 needed gems configurations
  11. `clock.rb`, where we list the cron jobs
  12. `app/jobs/tickets_due_date_reminder_job.rb`, the cron job that's invoked every midnight
  13. `app/jobs/ticket_due_date_reminder_email_sender_job.rb`, a BG job is enqueued by the previous crone job to send the ticket reminder email
  14. `spec/jobs/tickets_due_date_reminder_job_spec.rb`, TicketsDueDateReminderJob spec
  15. `spec/jobs/ticket_due_date_reminder_email_sender_job_spec.rb`, TicketDueDateReminderEmailSenderJob spec

To test it manually:

  open Sidekiq by `bundle exec sidekiq`, to check everything is processed at the background
  open Rails console by `rails c`
  add some users and tickets
  ```
  user = FactoryBot.create(:user)
  ticket = FactoryBot.create(:ticket, assigned_user: user)
  # explicitly run the self-triggered job now
  TicketsDueDateReminderJob.perform_now
  # you will see the ticket you just created is enqueued to be reminded of
  # play with the data to see different results, considered attributes:
  # users' 'send_due_date_reminder', 'due_date_reminder_interval', 'due_date_reminder_time' & 'time_zone'
  # tickets' 'assigned_user_id'm 'due_date', 'status_id'
  # enjoy!
  ```
