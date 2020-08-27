# frozen_string_literal: true

module Macro
  def self.Semantic(success: nil, failure: nil, message: nil, ctx_message: nil, **)
    task = Trailblazer::Activity::TaskBuilder::Binary(
      lambda { |ctx, **|
        ctx['operation_status'] = success || failure
        ctx['operation_message'] = message || (ctx[ctx_message] if ctx_message)
        true
      }
    )
    { task: task, id: "#{name}/#{__method__}_id_#{task.object_id}".underscore }
  end
end
