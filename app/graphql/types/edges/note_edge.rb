# frozen_string_literal: true

module Types::Edges
  class NoteEdge < Types::Base::Edge
    node_type Types::NoteType

    graphql_name 'NoteEdgeType'
  end
end
