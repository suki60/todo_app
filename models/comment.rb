class Comment < Sequel::Model
  set_primary_key :id
  many_to_one :user
  many_to_one :list

  def validate
    super
    errors.add(:text, 'text name cannot be empty') if text.empty?
  end

  def before_save
    self.created_at ||= Time.now
  end
end
