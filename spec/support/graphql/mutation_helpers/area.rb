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
            }
          }
        }
      )
    end

    def user_area_update_mutation
      %(
        mutation userAreaUpdate($input: AreaUpdateInput!) {
          userAreaUpdate(input: $input) {
            email
            taskAreas {
              name
            }
          }
        }
      )
    end

    def user_area_delete_mutation
      %(
        mutation userAreaDelete($input: DeleteInput!) {
          userAreaDelete(input: $input) {
            completed
          }
        }
      )
    end

    def move_area_within_areas_mutation
      %(
        mutation moveAreaWithinAreas($input: MoveInput!) {
          moveAreaWithinAreas(input: $input) {
            completed
          }
        }
      )
    end
  end
end
