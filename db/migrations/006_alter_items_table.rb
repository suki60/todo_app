Sequel.migration do
  change do
    alter_table :items do
      add_column :starred, TrueClass, default: false
    end
  end
end
