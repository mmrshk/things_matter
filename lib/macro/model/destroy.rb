# frozen_string_literal: true

module Macro
  module Model
    def self.Destroy(key: :model, bang: false)
      task = Trailblazer::Activity::TaskBuilder::Binary(
        lambda { |ctx, **|
          entity = ctx[key]

          bang ? entity.destroy! : entity.destroy
        }
      )

      { task: task, id: "#{name}/#{__method__}_id_#{task.object_id}".underscore }
    end
  end
end
