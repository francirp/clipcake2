Clipcake2::Application.routes.draw do
  # Routes for the Role resource:
  # CREATE
  get '/roles/new', controller: 'roles', action: 'new', as: 'new_role'
  post '/roles', controller: 'roles', action: 'create'

  # READ
  get '/roles', controller: 'roles', action: 'index', as: 'roles'
  get '/roles/:id', controller: 'roles', action: 'show', as: 'role'

  # UPDATE
  get '/roles/:id/edit', controller: 'roles', action: 'edit', as: 'edit_role'
  put '/roles/:id', controller: 'roles', action: 'update'

  # DELETE
  delete '/roles/:id', controller: 'roles', action: 'destroy'
  #------------------------------

  # Routes for the Text resource:
  # CREATE
  get '/texts/new', controller: 'texts', action: 'new', as: 'new_text'
  post '/texts', controller: 'texts', action: 'create'

  # READ
  get '/texts', controller: 'texts', action: 'index', as: 'texts'
  get '/texts/:id', controller: 'texts', action: 'show', as: 'text'

  # UPDATE
  get '/texts/:id/edit', controller: 'texts', action: 'edit', as: 'edit_text'
  put '/texts/:id', controller: 'texts', action: 'update'

  # DELETE
  delete '/texts/:id', controller: 'texts', action: 'destroy'
  #------------------------------

  # Routes for the Photo resource:
  # CREATE
  get '/photos/new', controller: 'photos', action: 'new', as: 'new_photo'
  post '/photos', controller: 'photos', action: 'create'

  # READ
  get '/photos', controller: 'photos', action: 'index', as: 'photos'
  get '/photos/:id', controller: 'photos', action: 'show', as: 'photo'

  # UPDATE
  get '/photos/:id/edit', controller: 'photos', action: 'edit', as: 'edit_photo'
  put '/photos/:id', controller: 'photos', action: 'update'

  # DELETE
  delete '/photos/:id', controller: 'photos', action: 'destroy'
  #------------------------------

  # Routes for the Page resource:
  # CREATE
  get '/pages/new', controller: 'pages', action: 'new', as: 'new_page'
  post '/pages', controller: 'pages', action: 'create'

  # READ
  get '/pages', controller: 'pages', action: 'index', as: 'pages'
  get '/pages/:id', controller: 'pages', action: 'show', as: 'page'

  # UPDATE
  get '/pages/:id/edit', controller: 'pages', action: 'edit', as: 'edit_page'
  put '/pages/:id', controller: 'pages', action: 'update'

  # DELETE
  delete '/pages/:id', controller: 'pages', action: 'destroy'
  #------------------------------

  # Routes for the Book resource:
  # CREATE
  get '/books/new', controller: 'books', action: 'new', as: 'new_book'
  post '/books', controller: 'books', action: 'create'

  # READ
  get '/books', controller: 'books', action: 'index', as: 'books'
  get '/books/:id', controller: 'books', action: 'show', as: 'book'

  # UPDATE
  get '/books/:id/edit', controller: 'books', action: 'edit', as: 'edit_book'
  put '/books/:id', controller: 'books', action: 'update'

  # DELETE
  delete '/books/:id', controller: 'books', action: 'destroy'
  #------------------------------

  # Routes for the User resource:
  # CREATE
  get '/users/new', controller: 'users', action: 'new', as: 'new_user'
  post '/users', controller: 'users', action: 'create'

  # READ
  get '/users', controller: 'users', action: 'index', as: 'users'
  get '/users/:id', controller: 'users', action: 'show', as: 'user'

  # UPDATE
  get '/users/:id/edit', controller: 'users', action: 'edit', as: 'edit_user'
  put '/users/:id', controller: 'users', action: 'update'

  # DELETE
  delete '/users/:id', controller: 'users', action: 'destroy'
  #------------------------------

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
