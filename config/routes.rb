ActionController::Routing::Routes.draw do |map|
  map.resources :posts
  map.root :controller => "static_pages", :action => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
