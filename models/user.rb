class User < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:name, :age, :gender, :latitude, :longitude]
  end
end
