class Buyer < ActiveRecord::Base
    has_many :vehicles, as: :owner
end