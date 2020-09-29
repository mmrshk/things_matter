# frozen_string_literal: true

module UserTask
  UpdateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskUpdate).schema do
        required(:taskProjects).each do
          required(:tasks).each do
            schema(::Schemas::Shared::TaskSchema)
          end
        end
      end
    end
  end
end
