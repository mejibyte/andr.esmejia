ActionController::Routing::Routes.draw do |map|
  map.resources :posts
  map.resource :user_session
  map.root :controller => "static_pages", :action => "home"
end
