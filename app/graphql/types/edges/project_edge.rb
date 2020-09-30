# frozen_string_literal: true

module Types::Edges
  class ProjectEdge < Types::Base::Edge
    node_type Types::ProjectType

    graphql_name 'ProjectEdgeType'
  end
end
