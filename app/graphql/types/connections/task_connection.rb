# frozen_string_literal: true

module Types::Connections
  class TaskConnection < Types::Base::Connection
    edge_type Types::Edges::TaskEdge

    graphql_name 'TaskConnectionType'
  end
end
