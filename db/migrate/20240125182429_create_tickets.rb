class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title, limit: 255
      t.text :description
      t.integer :assigned_user_id
      t.date :due_date
      t.integer :status_id
      t.integer :progress

      t.timestamps
    end

    add_index :tickets, :assigned_user_id
    # this attributes combination alongside with 'assigned_user_id' is used 1 time daily (at TicketsDueReminderJob)
    # including 'assigned_user_id' to the composite is debatable though (since it's separately indexed, but it's a must)
    add_index :tickets, [:due_date, :status_id]
  end
end
