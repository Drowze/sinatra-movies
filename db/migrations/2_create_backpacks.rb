Sequel.migration do
  change do
    create_table(:backpacks) do
      primary_key :id
      Integer :gold
    end
    create_table(:item_stacks) do
      primary_key :id
      String :name
      Integer :value_per_item
      Integer :quantity
    end

    alter_table(:item_stacks) do
      add_foreign_key(:backpack_id, :backpacks)
    end

    alter_table(:backpacks) do
      add_foreign_key(:user_id, :users)
    end
  end
end
