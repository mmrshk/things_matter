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

    def move_project_in_area_mutation
      %(
        mutation moveProjectInArea($input: MoveInput!) {
          moveProjectInArea(input: $input) {
            completed
          }
        }
      )
    end

    def move_project_within_area_mutation
      %(
        mutation moveProjectWithinArea($input: ProjectWithinAreaInput!) {
          moveProjectWithinArea(input: $input) {
            completed
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
