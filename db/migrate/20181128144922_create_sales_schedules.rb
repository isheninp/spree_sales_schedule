class CreateSalesSchedules < SpreeExtension::Migration[5.2]
  def change
    create_table :spree_sales_schedules do |t|
      t.integer :variant_id
      t.integer :number
      t.string :title
      t.datetime :start_time
      t.datetime :end_time
      t.text :description

      t.timestamps
    end
  end
end
