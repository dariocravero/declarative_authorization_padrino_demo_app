DeclarativeAuthorizationPadrinoDemoApp.controllers :users do
  get '/', :provides => :json, :protect => [{:action => :read, :resource => :users}] do
    User.with_permissions_to.all.to_json(:include => :roles) 
  end

  get '/:id', :provides => :json, :protect => [{:action => :read, :resource => :users}] do
    begin
      User.with_permissions_to.find(params[:id]).to_json(:include => :roles)
    rescue
      error 404, "Can't find it"
    end
  end

  post '/', :provides => :json, :protect => [{:action => :create, :resource => :users}] do
    User.create(params).to_json(:include => :roles)
  end

  put '/:id', :provides => :json, :protect => [{:action => :update, :resource => :users}] do
    u=User.find(params[:id])
    u.update_attributes(params)
    u.to_json(:include => :roles)
  end

  delete '/:id', :provides => :json, :protect => [{:action => :delete, :resource => :users}] do
    User.delete(params[:id]).to_json(:include => :roles)
  end
end
