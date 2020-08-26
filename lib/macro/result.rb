# frozen_string_literal: true

module Macro
  def self.Result(key:, relation: '')
    task = Trailblazer::Activity::TaskBuilder::Binary(
      lambda { |ctx, **|
        base_key = key.is_a?(Symbol) ? key : ctx.dig(**key.split('.').map(&:to_sym))
        base_value = ctx[base_key]

        ctx['result'] = base_value.blank? || relation.blank? ? base_value : relation.inject(base_value, :try)
      }
    )
    { task: task, id: "#{name}/#{__method__}_id_#{task.object_id}".underscore }
  end
end
