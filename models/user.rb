class User < Sequel::Model
  plugin :validation_helpers
  one_to_one :backpack

  def validate
    super
    validates_presence [:name, :age, :gender, :latitude, :longitude]
  end
end
