class LikeReflex < ApplicationReflex
  def like
    set_user_route
    @user.likes @route
  end

  def dislike
    set_user_route
    @user.dislikes @route
  end

  private

  def set_user_route
    @route = Route.find(element.dataset[:route_id])
    @user = User.find(element.dataset[:user_id])
  end
end