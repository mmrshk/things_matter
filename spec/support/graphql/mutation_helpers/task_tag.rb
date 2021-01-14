# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_task_tag_create_mutation
      %(
        mutation userTaskTagCreate($input: TaskTagCreateInput!) {
          userTaskTagCreate(input: $input) {
            completed
          }
        }
      )
    end

    def user_task_tag_update_mutation
      %(
        mutation userTaskTagUpdate($input: TaskTagUpdateInput!) {
          userTaskTagUpdate(input: $input) {
            completed
          }
        }
      )
    end

    def user_task_tag_delete_mutation
      %(
        mutation userTaskTagDelete($input: DeleteInput!) {
          userTaskTagDelete(input: $input) {
            completed
          }
        }
      )
    end
  end
end