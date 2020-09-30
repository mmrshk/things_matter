# frozen_string_literal: true

module GraphQL
  module QueryHelpers
    def projects_guery
      %(
        query projects(
          $after: String
          $before: String
          $first: Int
          $last: Int
          $filter: String
        ) {
          projects(
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
                name
                deadline
              }
            }
          }
        }
      )
    end
  end
end
