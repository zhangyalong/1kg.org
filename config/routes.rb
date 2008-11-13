ActionController::Routing::Routes.draw do |map|
  map.resources :users, :has_many => [:visited, 
																			:participations, 
																			:schools, 
																			:activities, 
																			:topics,
																			:sent,
																			:received]

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
  
  map.resources :schools, :has_one => :space, :has_many => [:visits, :photos] 
  
  map.resources :activities, :has_one => :space, :has_many => [:participations, :photos]

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
    admin.resources :boards
  end

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
