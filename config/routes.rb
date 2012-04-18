CrawlerDb::Application.routes.draw do
  resources :vulnerabilities

  resources :messages, :only => [:index, :create, :destroy]

  root :to => 'index#index'
end
