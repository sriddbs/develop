Rails.application.routes.draw do
  devise_for :users
  resources :links

  get ":key" => "links#forward", as: :link_redirect

  get "/" => "links#new", as: :root

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      scope(controller: :links_api) do
        post "short_url" => "links_api#generate_short_url"
        post "stats" => "links_api#get_statistics"
      end
    end
  end
end
