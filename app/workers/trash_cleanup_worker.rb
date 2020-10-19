# frozen_string_literal: true

class TrashCleanupWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(*_args)
    TrashCleanupService.call
  end
end
