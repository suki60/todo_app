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
    self.updated_at = Time.now if self.created_at
    self.created_at ||= Time.now
  end

  #method to create new list
  def self.new_list(name, items, user)
    list = List.new(name: name)

    items.each{ |item| list.items << Item.new(name: item[:name], description: item[:description], user: user, created_at: Time.now, updated_at: Time.now) }

    list.permissions << Permission.new(user: user, permission_level: 'read_write', created_at: Time.now,
                      updated_at: Time.now)
    list
  end

  #method to edit list
  def self.edit_list(id, name, items, user)
    binding.pry
    list = List.first(id: id)

    #convert items id to_i
=begin
    items.each do |item|
      item[:id] = item[:id].to_i
    end
=end

    #update name
    list.name = name

    #update exisiting items or create new ones
    items.each do |item|
      i = Item.first(id: item[:id])

      if i.nil?
        i = Item.new(name: item[:name], description: item[:description], list: list, user: user)
      else
        item_list = list.items.find{ |it| it.id == i.id}
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
    self.updated_at = Time.now if self.created_at
    self.created_at ||= Time.now
  end
end
