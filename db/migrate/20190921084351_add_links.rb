class AddLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :recruiters, :enterprise_id, :integer
    add_index :recruiters, :enterprise_id

    add_column :offers, :recruiter_id, :integer
    add_index :offers, :recruiter_id

    create_table :applications
    add_column :applications, :offer_id, :integer
    add_column :applications, :employee_id, :integer

    add_column :global_data, :recruiter_id, :integer
    add_column :global_data, :employee_id, :integer


  end
end
