Sequel.migration do
  change do
    create_table :lists do
      primary_key :id
      String :name, :null => false
      column :shared_with, 'enum("private", "shared", "public")', :null => false, :default => 'private'
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
