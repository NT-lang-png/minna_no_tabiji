Rails.application.routes.draw do

  #device

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  

#public

  root to: 'public/homes#top'


  scope module: :public do

    #tutorials
    get '/tutorials', to: 'tutorials#tutorial'

    #users
    resources :users, only: [:show, :edit, :update]do
      get 'confirm', to: 'users#confirm', as: 'confirm'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'
      member do
        get:bookmarks
      end
      #itineraries 各ユーザーのしおり一覧
      resources :itineraries, only: [:index], controller: 'user_itineraries'
      #bookmarks
      resources :bookmarks, only: [:index]
      #relationships
      resource :relationships, only: [:create, :destroy] do
        get 'followings', to: 'relationships#followings', as: 'followings'
        get 'followers', to: 'relationships#followers', as: 'followers'
      end
    end

    #my　カレントユーザーのしおり一覧
    resources :my, only:[] do
      resources :itineraries, only: [:index], controller: 'my'
    end

    #itineraries　indexは全ユーザーのしおり一覧
    resources :itineraries, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
      patch 'private_patch', to: 'itineraries#private_patch', as:'private_patch'

      #destinations
      resources :destinations, only: [:new, :edit, :create, :destroy, :update]do
        get 'edit_index', to: 'destinations#edit_destinations'
      end
      #bookmark
      resource :bookmarks, only: [:create, :destroy]
      #post_comments
      resources :post_comments, only: [:create, :destroy]
    end

    #searches
      get "/search", to: "searches#search"
  end


#admin

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :itineraries, only: [:show, :destroy]
    resources :post_comments, only: [:destroy]
    #searches
      get "/search", to: "searches#search"
  end

  get '/admin', to: 'admin/homes#top'





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
