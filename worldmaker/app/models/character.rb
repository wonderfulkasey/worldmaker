class Character < ApplicationRecord
    belongs_to :user
    belongs_to :world

    has_many :items
end