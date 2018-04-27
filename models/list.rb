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
  def self.new_list(name, items, user)
    items = [] if items.nil?
    list = List.new(name: name)

    items.each { |item| list.items << Item.new(name: item[:name], description: item[:description], user: user) }

    list.permissions << Permission.new(user: user, permission_level: 'read_write', created_at: Time.now,
                                       updated_at: Time.now)
    list
  end

  # method to edit list
  def self.edit_list(id, name, items, user)
    list = List.first(id: id)

    # update name
    list.name = name

    # update exisiting items or create new ones
    items.each do |item|
      i = Item.first(id: item[:id])

      if i.nil?
        i = Item.new(name: item[:name], description: item[:description], list: list, user: user)
      else
        item_list = list.items.find { |it| it.id == i.id }
        item_list.name = item[:name]
        item_list.description = item[:description]
      end
    end
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
