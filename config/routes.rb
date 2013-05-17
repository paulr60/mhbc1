Mhbc1::Application.routes.draw do

  get "events/new"

  get "events/edit"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :site_infos, only: [:edit, :update]
  resources :articles
  resources :photos
  resources :galleries
  resources :events

  root to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  match '/content', to: 'static_pages#content'

  match '/authoring_help', to: 'static_pages#help_general'
  match '/articles_help', to: 'static_pages#help_articles'
  match '/photos_help', to: 'static_pages#help_photos'
  match '/event_help', to: 'static_pages#help_events'
  match '/site_info_help', to: 'static_pages#help_site_info'
  match '/menu_tree_display', to: 'static_pages#menu_tree_display'

  match '/article_set', to: 'static_pages#article_set'

  match '/staff', to: 'static_pages#staff'
  match '/contact', to: 'static_pages#contact'
  match '/news', to: 'static_pages#news'
  match '/blog', to: 'static_pages#blog'
  match '/calendar', to: 'static_pages#calendar'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
