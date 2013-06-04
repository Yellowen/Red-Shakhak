class Advertise < ActiveRecord::Base

  # Callbacks
  before_save :calculate_expiration_cost_per_day_callback
  # Relations
  belongs_to :user
  has_many :logs, :as => :logable

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

  # Return the remaining days until expiration date of
  # current advertise advertisement period
  def remaining_days
    if is_active?
      d = self.deactive_date - DateTime.now
      return (d.to_i / 86400).to_i + 1

    else
      return 0
    end

  end

  # retuen true if advertise is not expired yet.
  def is_active?
    if self.deactive_date < DateTime.now
      return false
    end

    true
  end

  # Renew the current advertise for a new period of days,
  # and with the cost
  def renew(days, cost)
    if is_active?
      return nil
    else
      self.show_for_days = days
      self.cost = cost
      calc_date
      save

    end
  end

  # Calculate the expiration date of current peroid of advertise
  # in case of a new record or re_calculate the new cost_per_date
  def calculate_expiration_cost_per_day_callback
    if self.new_record?
      calc_date
    else
      if self.show_for_days_change
        return false
      end

      if self.cost_change
        self.cost_per_day = cost.to_f / show_for_days.to_f
      end

    end
  end

  private

  # Calculate the expiration date.
  def calc_date
    # Calculate the cost_per_day and deactive date
    self.deactive_date = DateTime.now

    if show_for_days > 0
      self.cost_per_day = cost.to_f / show_for_days.to_f
      self.deactive_date += show_for_days.days

    else
      self.cost_per_day = 0
    end

  end

end
