DroneTracker::Application.routes.draw do
  

  resources :statuses

  resources :departments

  devise_for :admins
  resources :comments
	resources :comment

	resources :departments
  resources :tickets 
	resources :ticket 

  

  root  'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  #root to: "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  
 	resources :users do
		collection do
		   get 'user_departments'
		 end
 end
	
	resources :tickets do
    resources :comments
  end


	get 'tickets/:asigned_to_operator/asigned_to' => 'tickets#asigned_to', as: :asigned_to
	get 'tickets/:user_id/posted_by' => 'tickets#posted_by', as: :posted_by
	get 'tickets/:resolved_by_operator/resolved_by' => 'tickets#resolved_by', as: :resolved_by
	get 'tickets/:ticket_id/comments_by_tickets' => 'tickets#comments_by_tickets', as: :comments_by_tickets
	#get 'tickets/search' => 'tickets#search', as: :search
	#post 'tickets/search' => 'tickets#search', as: :results
	#put 'tickets/:id/claim'=>'tickets#claim',as: :claim

  #put	'tickets/:ticket_id/comments/:id' => 'comments#update',as: :comments

#get 'users/user_departments' => 'users#user_departments', as: :user_departments

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
