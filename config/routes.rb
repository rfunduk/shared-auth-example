SharedAuthExample::Application.routes.draw do
  root :to => 'main#index'

  namespace :admin do
    root :to => 'main#index'

    mount MrMicro::Web, :at => '/mrmicro'

    resources :sessions
    match '/logout' => 'sessions#destroy', :as => :logout

    namespace :main do
      match ':action(/:id)'
    end
  end
end
