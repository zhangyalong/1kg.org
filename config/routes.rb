ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.with_options :controller => "users" do |user|
    user.signup 'signup', :action => "new"
    user.activate 'activate/:activation_code', :action => "activate"
    user.setting 'setting', :action => "edit"
  end
  
  map.resource :session
  map.with_options :controller => "sessions" do |session|
    session.login 'login', :action => "new"
    session.logout 'logout', :action => "destroy"
  end
  
  map.root :controller => "misc", :action => "index"
  
  map.resources :users do |user|
    user.resources :visiteds
    user.resources :participations
    
    # submitted by the user
    user.resources :schools
    user.resources :activities
    
    user.resources :topics
  end
    
  map.resources :geos
  map.connect '/geo_choice', :controller => 'geos_controller', :action => 'geo_choice'
  
  
  map.resources :schools do |school|
    school.resources :visits
    school.resources :photos
    school.resource  :space
  end
  
  map.resources :activities do |activity|
    activity.resources :participations
    activity.resources :photos
    activity.resource  :space
  end

  map.resources :boards do |board|
    board.resources :topics do |topic|
      topic.resources :posts
    end
  end
  
  map.admin '/admin', :controller => 'admin/misc', :action => 'index'
  map.namespace :admin do |admin|
    admin.resources :roles
    admin.resources :permissions
    admin.resources :users, :collection => {:search => :get}
    admin.resources :geos
    admin.resources :counties
    admin.resources :boards
    admin.resources :moderators
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
