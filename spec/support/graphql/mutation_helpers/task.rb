# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_task_create_mutation
      %(
        mutation userTaskCreate($input: TaskCreateInput!) {
          userTaskCreate(input: $input) {
            taskProjects {
              name
              tasks {
                id
                name
                description
                deleted
                deadline
                toDoDay
                done
              }
            }
          }
        }
      )
    end

    def user_task_update_mutation
      %(
        mutation userTaskUpdate($input: TaskUpdateInput!) {
          userTaskUpdate(input: $input) {
            taskProjects {
              name
              tasks {
                id
                name
                description
                deleted
                deadline
                toDoDay
                done
              }
            }
          }
        }
      )
    end

    def user_task_delete_mutation
      %(
        mutation userTaskDelete($input: DeleteInput!) {
          userTaskDelete(input: $input) {
            completed
          }
        }
      )
    end
  end
end
