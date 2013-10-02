class Advertise < ActiveRecord::Base

  acts_as_taggable


  SIZES = {
    1 => "1x1",
    2 => "1x2",
    3 => "2x1",
    4 => "2x2",
    5 => "2x3",
    6 => "3x2",
    7 => "3x1",
    8 => "1x3",
    9 => "3x3",
  }

  # Callbacks
  before_save :calculate_expiration_cost_per_day_callback
  # Relations
  belongs_to :user
  belongs_to :category
  has_many :logs, :as => :logable
  has_many :renews

  has_attached_file :picture, :styles => {
    :original => "1025x800>",
    :medium => "200x200>",
    :thumb => "100x100>" },
  :url => "/assets/advertises/pictures/:class/:attachment/:style/:filename",
  :path => ":rails_root/public/assets/advertises/pictures/:class/:attachment/:style/:filename"


  #validates :picture, :attachment_presence => true
  validates :title, presence: true, length: { maximum: 200 }
  validates :category_id, presence: true
  validates :show_for_days, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  validates :cost, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
  }

  validates_inclusion_of :size, :in => SIZES.keys

  # TODO: implement views counts
  def views
    0
  end

  # impelement like counts
  def likes
    0
  end

  def self.get_sizes
    SIZES.to_a.reverse_each {|x| x.reverse!}
  end

  def get_size
    SIZES[size]
  end
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
      #calc_date
      @renewing = true
      save
    end
  end

  # Calculate the expiration date of current peroid of advertise
  # in case of a new record or re_calculate the new cost_per_date
  def calculate_expiration_cost_per_day_callback

    if self.new_record? or is_renewing?
      calc_date
    else

      if is_active?
        if self.show_for_days_change
          return false
        end
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

  def is_renewing?
    if @renewing
      return true
    end
    false
  end

end
