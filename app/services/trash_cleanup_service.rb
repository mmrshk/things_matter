# frozen_string_literal: true

class TrashCleanupService
  START_DATE = Time.zone.today - 1.month
  END_DATE = Time.zone.today

  def self.call
    ActiveRecord::Base.transaction do
      Task.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)
      Note.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)

      TaskProject.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)
      NoteProject.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)

      TaskArea.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)
      NoteArea.where(deleted: true, deleted_date: START_DATE..END_DATE).each(&:destroy!)

    rescue ActiveRecord::ActiveRecordError => e
      Raven.capture_exception(e)
    end
  end
end
