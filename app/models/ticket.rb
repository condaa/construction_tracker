class Ticket < ApplicationRecord
  # Enums
  enum status_id: { backlog: 0, selected_to_do: 1, in_progress: 2, done: 3 }

  # Associations
  belongs_to :assigned_user, class_name: 'User'

  # Validations
  validates_presence_of :title, :status_id
  validates_numericality_of :progress, allow_nil: true, only_integer: true, greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100

  # Scopes
  scope :not_done, -> { where.not(status_id: :done) }
  scope :with_remindable_status, -> { not_done }

  # assessment comment: we may need to ask the PM &| customers if they need to receive reminders if 'due_date' is
  # changed and this change met the reminder date
  # e.g. user's (send_due_date_reminder, due_date_reminder_interval) are (true, 1)
  #      and ticket's due_date is changed to tomorrow
  # so in such case we will add a callback to handle that

end
