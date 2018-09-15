FactoryBot.define do
  to_create { |instance| instance.save(raise_on_failure: true) }
end
