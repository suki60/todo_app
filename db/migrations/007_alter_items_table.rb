Sequel.migration do
  change do
    alter_table :items do
      add_column :due_date, Date
    end
  end
end
