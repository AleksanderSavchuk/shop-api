class ProductPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    user.role?(:admin) || user.role?(:client)
  end

  def show?
    user.role?(:admin) || user.role?(:client)
  end

  def create?
    user.role? :admin
  end

  def new?
    user.role? :admin
  end

  def update?
    user.role? :admin
  end

  # def edit?
    # update?
  # end

  def destroy?
    user.role? :admin
  end
end
