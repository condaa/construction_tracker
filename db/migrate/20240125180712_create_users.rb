class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 255
      t.string :mail, limit: 255
      t.boolean :send_due_date_reminder
      t.integer :due_date_reminder_interval
      t.time :due_date_reminder_time
      t.string :time_zone, limit: 60

      # removed since they don't exist at the table diagram
      # t.timestamps
    end

    add_index :users, :mail, unique: true
    # used by 'TicketsDueDateReminderJob' which iterates over all users with this flag enabled
    add_index :users, :send_due_date_reminder
  end
end
