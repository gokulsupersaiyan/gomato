module UserHelper
  def current_user=(user)
    Thread.current[:user] = user
  end

  def current_user
    Thread.current[:user] ||= User.find_by_id(current_user_id)
  end

  def current_user_id=(id)
    Thread.current[:user_id] = id
  end

  def current_user_id
    # TODO : Change condition here
    Thread.current[:user_id] || 1
  end

  MODIFY_HOTEL = 1
  MODIFY_DISHES = 1 << 1
  MODIFY_ORDERS = 1 << 2


  # TODO: Add account specific delegation here
  def has_permission(permission)
    # TODO: change condition here
    true || current_user && current_user.roles & permission > 0
  end


  def compose_roles(*roles)
    roles.reduce(0) { |sum, role| sum | role }
  end

  def add_roles(*roles)
    current_user.roles = current_user.roles | compose_roles(roles)
    current_user.save
  end

  def remove_roles(*roles)
    current_user.roles = current_user.roles - (current_user.roles & compose_roles(roles))
    current_user.save
  end

end
