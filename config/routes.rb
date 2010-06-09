ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :only => [:index, :show]
  map.resource :user_session
  
  map.namespace :admin do |admin|
    admin.resources :posts, :active_scaffold => true
  end
  map.root :controller => "static_pages", :action => "home"
end
