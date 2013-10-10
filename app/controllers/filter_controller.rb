class FilterController < ApplicationController
  layout false

  def categories
    @categories = Category.all
  end

  def index
      @categories = Category.all
  end

end
