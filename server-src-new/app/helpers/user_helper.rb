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
    Thread.current[:user_id]
  end

  MODIFY_HOTEL = 1
  MODIFY_DISHES = 1 << 1


  # TODO: Add account specifc delegation here

  def has_permission(permission)
    # TODO: change condition here
    true || current_user && current_user.roles & permission > 0
  end

end
