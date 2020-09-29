# frozen_string_literal: true

module UserTask
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskCreate).schema do
        required(:taskProjects).each do
          required(:tasks).each do
            schema(::Schemas::Shared::TaskSchema)
          end
        end
      end
    end
  end
end
