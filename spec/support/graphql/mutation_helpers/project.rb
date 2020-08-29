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
  end
end
