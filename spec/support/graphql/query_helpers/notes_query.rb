# frozen_string_literal: true

module GraphQL
  module QueryHelpers
    def notes_guery
      %(
        query notes(
          $after: String
          $before: String
          $first: Int
          $last: Int
          $input: NoteFilterInput
        ) {
          notes(
            after: $after
            before: $before
            first: $first
            last: $last
            input: $input
          ) {
            totalCount
            pageInfo {
              endCursor
              hasNextPage
              hasPreviousPage
              startCursor
            }
            edges {
              cursor
              node {
                id
                default
                description
                name
              }
            }
          }
        }
      )
    end
  end
end
