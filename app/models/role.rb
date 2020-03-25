# frozen_string_literal: true

class Role < ApplicationRecord
  ROLE_NAMES = %w[admin manager client].freeze

  has_and_belongs_to_many :users

  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  validates_inclusion_of :name, in: ROLE_NAMES, message: '%{value} is not a valid role name'
end
