class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.role? :admin
  end

  def update?
    user.role? :admin
  end

  def destroy?
    user.role? :admin
  end
end
