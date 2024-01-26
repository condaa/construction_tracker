class User < ApplicationRecord
  
  # Associations
  has_many :tickets, foreign_key: :assigned_user_id

  # Validations
  validates_presence_of :name
  validates :mail, presence: true, uniqueness: true
  validates :mail, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { mail.present? }
  validates_presence_of :due_date_reminder_time, if: :send_due_date_reminder
  validates_numericality_of :due_date_reminder_interval, only_integer: true, greater_than_or_equal_to: 0,
    if: :send_due_date_reminder
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.all.map(&:name)

  # Scopes
  scope :with_due_date_reminder, -> { where(send_due_date_reminder: true) }

  # Attributes
  def due_date_reminder_time_on_date(date)
    Time.zone.local(
      date.year,
      date.month,
      date.day,
      self.due_date_reminder_time.hour,
      self.due_date_reminder_time.min,
      self.due_date_reminder_time.sec
    )
  end

end
