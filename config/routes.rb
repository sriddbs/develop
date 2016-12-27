Rails.application.routes.draw do
  resources :links

  get ":key" => "links#forward", as: :link_redirect

  get "/" => "links#index", as: :root
end
