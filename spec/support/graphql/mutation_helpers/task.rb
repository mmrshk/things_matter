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

    def move_task_in_project_mutation
      %(
        mutation moveTaskInProject($input: MoveInput!) {
          moveTaskInProject(input: $input) {
            completed
          }
        }
      )
    end

    def move_task_within_project_mutation
      %(
        mutation moveTaskWithinProject($input: TaskWithinProjectInput!) {
          moveTaskWithinProject(input: $input) {
            completed
          }
        }
      )
    end
  end
end
