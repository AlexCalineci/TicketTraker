class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :user_post
			t.string :user_id
      t.text :subject
      t.text :obs
      t.string :status
      t.integer :department_id
      t.string :resolved_by_operator
      t.string :resolved_data
      t.string :priority
      t.string :asigned_to_operator
      t.timestamps
    end
  end
end
