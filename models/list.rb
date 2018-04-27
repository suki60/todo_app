class List < Sequel::Model
  set_primary_key :id
  one_to_many :items
  one_to_many :permissions
  one_to_many :logs

  def validate
    super
    errors.add(:name, 'list name cannot be empty') if name.empty?
  end

  def before_save
    self.updated_at = Time.now
    self.created_at ||= updated_at
  end

  # method to create new list
  def self.new_list(name, user)
    list = List.new(name: name)

    list.permissions << Permission.new(user: user, permission_level: 'read_write', created_at: Time.now,
                                       updated_at: Time.now)
    list
  end
end

class Item < Sequel::Model
  set_primary_key :id
  many_to_one :user
  many_to_one :list

  def validate
    super
    errors.add(:name, 'item name cannot be empty') if name.empty?
  end

  def before_save
    self.updated_at = Time.now
    self.created_at ||= updated_at
  end
end
