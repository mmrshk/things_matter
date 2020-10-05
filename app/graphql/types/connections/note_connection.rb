# frozen_string_literal: true

module Types::Connections
  class NoteConnection < Types::Base::Connection
    edge_type Types::Edges::NoteEdge

    graphql_name 'NoteConnectionType'
  end
end
