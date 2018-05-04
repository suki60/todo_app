Sequel.migration do
  change do
    create_table :comments do
      primary_key :id
      String :text, text: true
      DateTime :created_at
      foreign_key :list_id, :lists, null: false
      foreign_key :user_id, :users, null: false
    end
  end
end
