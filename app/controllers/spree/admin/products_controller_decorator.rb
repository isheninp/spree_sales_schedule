Spree::Admin::ProductsController.class_eval do
  def sales_schedules
    #load_resource
    @sales_schedules = Spree::SalesSchedule.joins({:variant => :product}).where("spree_products.id=?", @product.id).order(:number)
  end
end