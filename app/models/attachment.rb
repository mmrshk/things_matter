# == Schema Information
#
# Table name: attachments
#
#  id              :uuid             not null, primary key
#  attachable_id   :uuid
#  attachable_type :string
#  type            :string
#  file            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true, optional: true

  after_destroy :remove_file

  private

  def remove_file
    remove_file!
  end
end
