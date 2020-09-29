# frozen_string_literal: true

module Types::Connections
  class ProjectConnection < Types::Base::Connection
    edge_type Types::Edges::ProjectEdge

    graphql_name 'ProjectConnectionType'
  end
end
