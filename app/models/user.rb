class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  has_and_belongs_to_many :roles

  before_create :assign_roles

  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  def assign_roles
    return if roles.any?

    self.roles = [Role.find_or_create_by(name: 'client')]
  end
end
