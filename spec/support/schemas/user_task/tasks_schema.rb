# frozen_string_literal: true

require_relative '../shared/task_schema.rb'

module UserTask
  TasksSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:tasks).schema do
        required(:totalCount).filled(:int?)
        required(:pageInfo).schema do
          required(:startCursor).filled(:str?)
          required(:endCursor).filled(:str?)
          required(:hasNextPage).filled(:bool?)
          required(:hasPreviousPage).filled(:bool?)
        end
        required(:edges).each do
          required(:cursor).filled(:str?)
          required(:node).schema(::Schemas::Shared::TaskSchema)
        end
      end
    end
  end
end
