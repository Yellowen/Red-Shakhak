class Advertise < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :description, :show_for_days, :cost

  validates :title, presence: true, length: { maximum: 200 }
  validates :show_for_days, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  validates :cost, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

end
