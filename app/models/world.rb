class World < ApplicationRecord
    has_many :characters
    has_many :items, through: :characters
end