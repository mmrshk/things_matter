# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    # user mutations
    field :user_sign_up, mutation: Mutations::User::SignUp
    field :user_sign_out, mutation: Mutations::User::SignOut
    field :user_sign_in, mutation: Mutations::User::SignIn

    field :refresh_token, mutation: Mutations::Auth::RefreshToken

    field :user_add_favorite_movie, mutation: Mutations::User::Movie::AddFavorite
    field :user_add_watchlist_movie, mutation: Mutations::User::Movie::AddWatchlist

    # lists mutations
    field :user_list_add_item, mutation: Mutations::User::List::AddItem
    field :user_list_remove_item, mutation: Mutations::User::List::RemoveItem
    field :user_create_list, mutation: Mutations::User::List::Create
    field :user_delete_list, mutation: Mutations::User::List::Delete
  end
end
