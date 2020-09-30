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

    def user_note_delete_mutation
      %(
        mutation userNoteDelete($input: DeleteInput!) {
          userNoteDelete(input: $input) {
            completed
          }
        }
      )
    end

    def user_note_default_mutation
      %(
        mutation userNoteDefault($input: NoteDefaultInput!) {
          userNoteDefault(input: $input) {
            completed
          }
        }
      )
    end

    def move_note_in_project_mutation
      %(
        mutation moveNoteInProject($input: MoveInput!) {
          moveNoteInProject(input: $input) {
            completed
          }
        }
      )
    end

    def move_note_within_project_mutation
      %(
        mutation moveNoteWithinProject($input: NoteWithinProjectInput!) {
          moveNoteWithinProject(input: $input) {
            completed
          }
        }
      )
    end
  end
end
