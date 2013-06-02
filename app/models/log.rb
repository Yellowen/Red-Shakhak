class Log < ActiveRecord::Base
  belongs_to :logable, :polymorphic => true
  belongs_to :user
end
