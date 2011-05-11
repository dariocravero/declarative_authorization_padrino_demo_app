class User < ActiveRecord::Base
  using_access_control

  has_many :roles
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end
end
