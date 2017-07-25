class Person < ApplicationRecord
  belongs_to :group
  has_many :notes
end
