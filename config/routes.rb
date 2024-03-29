# frozen_string_literal: true

require 'graphiql/rails'

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
end
