require 'sequel'

class User < Sequel::Model
  set_primary_key :id
  one_to_many :items
  one_to_many :permissions
  one_to_many :logs

  def validate
    super
    validates_presence :name
    validates_format /\A[A-Za-z]/, :name, message: 'is not a valid name'
    validates_min_length 3, :name
    validates_max_length 8, :name
    validates_unique :name
  end
end
