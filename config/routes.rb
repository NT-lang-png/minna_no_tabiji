Rails.application.routes.draw do

  #device

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

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
      member do
        get 'bookmarks'
        get 'confirm'
        patch 'withdraw'
        #カレントユーザーのしおり一覧
        get 'my', to: 'my#my_index'
      end

      #itineraries 各ユーザーのしおり一覧
      resources :itineraries, only: [:index], controller: 'user_itineraries'
      #relationships
      resource :relationships, only: [:create, :destroy] do
        get 'followings', to: 'relationships#followings', as: 'followings'
        get 'followers', to: 'relationships#followers', as: 'followers'
      end
    end

    #itineraries　indexは全ユーザーのしおり一覧
    resources :itineraries, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
      member do
        patch 'status_change', to: 'itineraries#status_change', as:'status_change'
      end

      #destinations
      resources :destinations, only: [:new, :edit, :create, :destroy, :update]do
        collection do
          get 'edit_index', to: 'destinations#edit_destinations'
        end
      end
      #bookmark
      resource :bookmarks, only: [:create, :destroy]
      #post_comments
      resources :post_comments, only: [:create, :destroy]
    end

    #searches
      get "/search", to: "searches#search"
      get "/search_region", to:"searches#search_region"
  end


#admin

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :itineraries, only: [:show, :destroy]
    resources :post_comments, only: [:index, :destroy]
    #searches
      get "/search", to: "searches#search"
  end

  get '/admin', to: 'admin/homes#top'





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
