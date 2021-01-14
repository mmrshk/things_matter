# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_note_tag_create_mutation
      %(
        mutation userNoteTagCreate($input: NoteTagCreateInput!) {
          userNoteTagCreate(input: $input) {
            completed
          }
        }
      )
    end

    def user_note_tag_update_mutation
      %(
        mutation userNoteTagUpdate($input: NoteTagUpdateInput!) {
          userNoteTagUpdate(input: $input) {
            completed
          }
        }
      )
    end

    def user_note_tag_delete_mutation
      %(
        mutation userNoteTagDelete($input: DeleteInput!) {
          userNoteTagDelete(input: $input) {
            completed
          }
        }
      )
    end
  end
end
