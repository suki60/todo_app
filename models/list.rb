require 'sequel'

class List < Sequel::Model
  set_primary_key :id
  one_to_many :items
  one_to_many :permissions
  one_to_many :logs

  def validate
    super
    errors.add(:name, 'list name cannot be empty') if name.empty?
  end

  #method to create new list
  def self.new_list(name, items, user)
    list = List.new(name: name, created_at: Time.now)

    items.each{ |item| list.items << Item.new(name: item[:name], description: item[:description], user: user, created_at: Time.now, updated_at: Time.now) }

    list.permissions << Permission.new(user: user, permission_level: 'read_write', created_at: Time.now,
                      updated_at: Time.now)
    list
  end

  #method to edit list
  def self.edit_list(id, name, items, user)
    list = List.first(id: id)

    #update name and update_at
    list.name = name
    list.updated_at = Time.now
    binding.pry
    #update exisiting items or create new ones
    items.each do |item|
      i = Item.first(id: item[:id])

      if i.nil?
        i = Item.new(name: item[:name], description: item[:description], list: list, user: user,
                    created_at: Time.now, updated_at: Time.now)
      else
        #list.items.each { |old_item| pu  }
        i.name = item[:name]
        i.description = item[:description]
        i.updated_at = Time.now
      end
    end
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
end
