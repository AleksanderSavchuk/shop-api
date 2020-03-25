class UserPolicy < ApplicationPolicy
  def index?
    user.role? :admin
  end

  def show?
    user.role?(:admin) || client_is_the_owner?
  end

  def create?
    true
  end

  def update?
    user.role?(:admin) || client_is_the_owner?
  end

  def destroy?
    user.role? :admin
  end

  def client_is_the_owner?
    return if record.id != user.id

    true
  end
end
