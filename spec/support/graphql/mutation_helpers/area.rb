# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_area_create_mutation
      %(
        mutation userAreaCreate($input: AreaCreateInput!) {
          userAreaCreate(input: $input) {
            email
            taskAreas {
              name
              type
            }
          }
        }
      )
    end
  end
end
