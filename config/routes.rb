AndrEsmejia::Application.routes.draw do |map|
  map.resources :posts, :only => [:index, :show, :new, :create]
  map.resource :user_session

  map.namespace :admin do |admin|
    admin.resources :posts, :active_scaffold => true
    admin.resources :uploads, :active_scaffold => true
  end
  map.root :controller => "static_pages", :action => "home"
end