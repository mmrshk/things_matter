# frozen_string_literal: true

module UserNote
  NotesSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:notes).schema do
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
            required(:description).filled(:str?)
            required(:default).filled(:bool?)
          end
        end
      end
    end
  end
end
