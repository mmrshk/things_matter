# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_project_create_mutation
      %(
        mutation userProjectCreate($input: ProjectCreateInput!) {
          userProjectCreate(input: $input) {
            email
            taskProjects {
              name
              type
              deadline
            }
          }
        }
      )
    end

    def user_project_update_mutation
      %(
        mutation userProjectUpdate($input: ProjectUpdateInput!) {
          userProjectUpdate(input: $input) {
            email
            taskProjects {
              name
              type
              deadline
            }
            noteProjects {
              name
              type
              deadline
            }
          }
        }
      )
    end

    def user_project_delete_mutation
      %(
        mutation userProjectDelete($input: DeleteInput!) {
          userProjectDelete(input: $input) {
            completed
          }
        }
      )
    end
  end
end
