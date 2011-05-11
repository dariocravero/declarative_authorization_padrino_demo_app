DeclAuthApp.controllers :demo do
  get :index, :map => "/" do
    render "index"
  end

  get :current_user, :provides => :json do
    current_user.to_json(:include => :roles)
  end
  post :current_user, :provides => :json do
    Authorization.current_user= User.find(params[:id])
    current_user.to_json(:include => :roles)
  end

  post :role, :provides => :json do
    role = Role.find_by_title(params[:role])
    role = Role.create({:title => params[:role]}) unless role

    User.find(params[:user]).roles << role 

    current_user.reload
    current_user.to_json(:include => :roles)
  end
  delete :role, :provides => :json do
    u=User.find(params[:user])
    new_roles = []
    u.roles.each do |role|
      new_roles.push(role) if role.title != params[:role]
    end
    u.roles=new_roles
    current_user.reload
    current_user.to_json(:include => :roles)
  end
end
