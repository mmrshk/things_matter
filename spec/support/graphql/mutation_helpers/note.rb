# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_note_create_mutation
      %(
        mutation userNoteCreate($input: NoteCreateInput!) {
          userNoteCreate(input: $input) {
            noteProjects {
              name
              notes {
                id
                name
                description
                default
              }
            }
          }
        }
      )
    end

    def user_note_update_mutation
      %(
        mutation userNoteUpdate($input: NoteUpdateInput!) {
          userNoteUpdate(input: $input) {
            noteProjects {
              name
              notes {
                id
                name
                description
                default
              }
            }
          }
        }
      )
    end
  end
end
