class Backpack < Sequel::Model
  plugin :validation_helpers
  many_to_one :user
  one_to_many :item_stacks

  def validate
    super
    validates_presence :gold 
  end
end
