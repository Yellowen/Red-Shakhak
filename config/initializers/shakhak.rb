require 'assets/helpers'

ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)

Rails.application.assets.context_class.instance_eval do
  include AssetsHelper
end
