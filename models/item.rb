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
