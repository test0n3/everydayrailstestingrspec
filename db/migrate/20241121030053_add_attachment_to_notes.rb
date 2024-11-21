class AddAttachmentToNotes < ActiveRecord::Migration[7.2]
  def change
    add_column :notes, :attachment, :attachment
  end
end
