# frozen_string_literal: true

module UserTaskProject
  ProjectsSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:projects).schema do
        required(:totalCount).filled(:int?)
        required(:pageInfo).schema do
          required(:startCursor).filled(:str?)
          required(:endCursor).filled(:str?)
          required(:hasNextPage).filled(:bool?)
          required(:hasPreviousPage).filled(:bool?)
        end
        required(:edges).each do
          required(:cursor).filled(:str?)
          required(:node).schema do
            required(:id).filled(:str?)
            required(:name).filled(:str?)
            required(:deadline).filled(:str?)
          end
        end
      end
    end
  end
end
