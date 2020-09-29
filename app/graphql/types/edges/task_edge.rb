# frozen_string_literal: true

module Types::Edges
  class TaskEdge < Types::Base::Edge
    node_type Types::TaskType

    graphql_name 'TaskEdgeType'
  end
end
