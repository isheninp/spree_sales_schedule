Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'sales_schedules_admin_tab',
  insert_bottom: '[data-hook="admin_product_sub_tabs"]',
  text: '<%= tab(:sales_schedules, label: "sales_schedules") %>'
)