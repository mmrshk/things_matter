# frozen_string_literal: true

module GraphQL
  module QueryHelpers
    def tasks_guery
      %(
        query tasks(
          $after: String
          $before: String
          $first: Int
          $last: Int
          $filter: String
        ) {
          tasks(
            after: $after
            before: $before
            first: $first
            last: $last
            filter: $filter
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
                description
                name
                done
                deleted
                deadline
                toDoDay
              }
            }
          }
        }
      )
    end
  end
end
