class AddPictureToAdvertises < ActiveRecord::Migration
  def change
    add_attachment :advertises, :picture
  end
end
