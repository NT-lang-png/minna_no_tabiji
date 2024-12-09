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
    resources :users, only: [:edit, :update]do
      collection do
        get 'confirm', to: 'users#confirm', as: 'confirm'
        patch 'withdraw', to: 'users#withdraw', as: 'withdraw'
        get '/show/:id', to: 'users#show', as: 'show'
      end
      #itineraries 各ユーザーのしおり一覧
      resources :itineraries, only: [:index], controller: 'user_itineraries'
      #favorites
      resource :favorites, only: [:index]
      #relationships
      resource :relationships, only: [:create, :destroy] do
        collection do
          get 'followings', to: 'relationships#followings', as: 'followings'
          get 'followers', to: 'relationships#followers', as: 'followers'
        end
      end
    end

    #my　カレントユーザーのしおり一覧
    resources :my, only:[] do
      resources :itineraries, only: [:index], controller: 'my'
    end

    #itineraries　indexは全ユーザーのしおり一覧
    resources :itineraries, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
      collection do
        post 'private_post', to: 'itineraries#private_post', as:'private_post'
        patch 'private_patch', to: 'itineraries#private_patch', as:'private_patch'
      end
      #destinations
      resources :destinations, only: [:create, :destroy, :update]
      #favorites
      resource :favorites, only: [:create, :destroy]
      #comments
      resources :comments, only: [:create, :destroy]
    end

    #searches
    resources :searches, only: [:index]
  end


#admin

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :itineraries, only: [:show, :destroy]
    resources :comments, only: [:destroy]
    resources :searches, only: [:index]
  end

  get '/admin', to: 'admin/homes#top'





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
