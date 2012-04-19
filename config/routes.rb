CrawlerDb::Application.routes.draw do
  resources :vulnerabilities

  resources :messages, :only => [:index, :create, :destroy]
  
  match 'dump' => 'messages#dump'
  match 'clear' => 'vulnerabilities#clear'

  root :to => 'index#index'
end
