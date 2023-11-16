class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Define abilities for posts
    can :destroy, Post, author_id: user.id
    can :destroy, Post, user: { role: 'admin' } if user.role == 'admin'

    # Define abilities for comments
    can :destroy, Comment, user_id: user.id
    can :destroy, Comment, user: { role: 'admin' } if user.role == 'admin'
  end
end
