CrawlerDb::Application.routes.draw do
  resources :vulnerabilities

  resources :messages, :only => [:index, :create, :destroy]
  
  match 'dump' => 'index#dump'

  root :to => 'index#index'
end
