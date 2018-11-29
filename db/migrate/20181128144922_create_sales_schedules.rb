class CreateSalesSchedules < SpreeExtension::Migration[5.2]
  def change
    create_table :spree_sales_schedules do |t|
      t.string :product_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :group
      t.integer :places_left

      t.timestamps
    end
  end
end
