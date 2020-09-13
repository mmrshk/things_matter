# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_task_project_create_mutation
      %(
        mutation userTaskProjectCreate($input: TaskProjectCreateInput!) {
          userTaskProjectCreate(input: $input) {
            email
            taskProjects {
              name
              deadline
            }
          }
        }
      )
    end

    def user_task_project_update_mutation
      %(
        mutation userTaskProjectUpdate($input: TaskProjectUpdateInput!) {
          userTaskProjectUpdate(input: $input) {
            email
            taskProjects {
              name
              deadline
            }
            noteProjects {
              name
              deadline
            }
          }
        }
      )
    end

    def user_task_project_delete_mutation
      %(
        mutation userTaskProjectDelete($input: DeleteInput!) {
          userTaskProjectDelete(input: $input) {
            completed
          }
        }
      )
    end
  end
end
