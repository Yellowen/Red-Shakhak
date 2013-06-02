class Advertise < ActiveRecord::Base

  # Callbacks
  before_save :calculate_deactive_date
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

  def remaining_days
    if is_active?
      d = self.deactive_date - DateTime.now
      return (d.to_i / 86400).to_i + 1

    else
      return 0
    end

  end

  def is_active?
    if self.deactive_date < DateTime.now
      return false
    end

    true
  end

  def calculate_deactive_date
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

  def calc_date
    # Calculate the cost_per_day and deactive date

    # BUG: Find a way to renew the show_for_days
    self.deactive_date = DateTime.now

    if show_for_days > 0
      self.cost_per_day = cost.to_f / show_for_days.to_f
      self.deactive_date += show_for_days.days

    else
      self.cost_per_day = 0
    end

  end

end
