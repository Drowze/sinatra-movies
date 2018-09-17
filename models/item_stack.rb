class ItemStack < Sequel::Model
  plugin :validation_helpers
  many_to_one :backpack

  def validate
    super
  end
end
