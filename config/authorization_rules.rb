authorization do
  role :guest do
    has_permission_on :users, :to => :create
  end

  role :user do
    has_permission_on :users, :to => :manage do
      if_attribute :id => is {user.id}
    end
  end

  role :admin do
    has_permission_on :users, :to => :manage
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
