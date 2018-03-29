Sequel.migration do

  change do
    
    create_table :items do
      primary_key :id
      String :name, null: false
      String :description
      foreign_key :user_id, :users, null: false
      foreign_key :list_id, :lists, null: false
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
