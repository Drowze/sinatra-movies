Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name, null: false
      Integer :age, null: false
      Integer :gender, null: false
      Float :longitude, null: false
      Float :latitude, null: false
    end
  end
end
