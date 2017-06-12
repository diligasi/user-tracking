class ContactPath < ApplicationRecord
  belongs_to :contact, optional: true
end
