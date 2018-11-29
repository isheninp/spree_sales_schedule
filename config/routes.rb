Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :sales_schedules
  end
  #resources :sales_schedule
  #get "/sales_schedule" => "sales_schedule#index"
    
  
end

