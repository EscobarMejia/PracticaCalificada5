Myrottenpotatoes::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  #resources :movies
  resources :movies do
  resources :reviews
end
  get '/not_found', to: 'movies#not_found', as: :not_found
  root :to => redirect('/movies')
end
