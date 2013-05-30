require 'date'


class Advertise < ActiveRecord::Base

  belongs_to :user

  acts_as_taggable

  validates :title, presence: true, length: { maximum: 200 }
  validates :show_for_days, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  validates :cost, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  def save(*args)

    # Calculate the cost_per_day and deactive date.
    if show_for_days > 0
      self.cost_per_day = cost / show_for_days
      self.deactive_date = DateTime.now + 10
    else
      self.cost_per_day = 0
      self.deactive_date = DateTime.now
    end

    super
  end

  def is_deactive?
    if self.datetime < DateTime.now
      return true
    end

    false
  end

end
