class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    @user = user
    self.send(user.role_name)
  end

  def user
    can :manage, Advertise do |advertise|
      advertise.try(:user) == @user || @user.role?(:moderator)
    end
  end

  def admin
    can :manage, :all
  end

  def guest
  end

  def moderator
  end

end
