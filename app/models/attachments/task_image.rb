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
module Attachments
  class TaskImage < ::Attachment
    mount_uploader :file, BaseUploader
  end
end
