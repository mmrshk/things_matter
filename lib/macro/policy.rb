# frozen_string_literal: true

module Macro
  def self.Policy(policy:, rule:, current_user: nil, record: ->(ctx) { ctx[:model] }, **)
    task = Trailblazer::Activity::TaskBuilder::Binary(
      lambda { |ctx, **|
        user = current_user || ctx[:current_user]

        is_authorized = user ? policy.new(record[ctx], user: user).apply(rule) : false

        ctx['operation_status'] = :not_authorized unless is_authorized

        is_authorized
      }
    )
    { task: task, id: "#{name}/#{__method__}_id_#{task.object_id}".underscore }
  end
end
