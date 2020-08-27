# frozen_string_literal: true

module Macro
  module Model
    def self.FindBy(entity, attribute: :id, value_path: %i[params id], lazy: false)
      task = Trailblazer::Activity::TaskBuilder::Binary(
        lambda { |ctx, **|
          return true if ctx[:model].present? && lazy

          ctx[:model] = entity.find_by(
            attribute => ctx.to_hash.dig(*value_path)
          )
        }
      )

      { task: task, id: "#{name}/#{__method__}_id_#{task.object_id}".underscore }
    end
  end
end
