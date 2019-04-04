Spree::Core::Engine.add_routes do
  
  namespace :admin do
    resources :sales_schedules
    
    resources :products, only: [] do
      get :sales_schedules, on: :member
      resources :sales_schedules do
#        collection do
#          post :update_positions
#        end
      end
    end
    
  end
  #resources :sales_schedule
  #get "/sales_schedule" => "sales_schedule#index"
  
  #get "/sales_schedule" => "sales_schedule#index", as: 'related_schedule'
    
  
end

