class Contact < ApplicationRecord
  validates_uniqueness_of :email
  has_many :contact_paths
  paginates_per 10
end
