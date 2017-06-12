class Contact < ApplicationRecord
  has_many :contact_paths
  paginates_per 10
end
