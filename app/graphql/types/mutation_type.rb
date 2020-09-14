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

    # areas mutations
    field :user_area_create, mutation: Mutations::User::Area::Create
    field :user_area_update, mutation: Mutations::User::Area::Update
    field :user_area_delete, mutation: Mutations::User::Area::Delete

    # projects mutations
    field :user_task_project_create, mutation: Mutations::User::TaskProject::Create
    field :user_task_project_update, mutation: Mutations::User::TaskProject::Update
    field :user_task_project_delete, mutation: Mutations::User::TaskProject::Delete

    field :user_note_project_create, mutation: Mutations::User::NoteProject::Create
    field :user_note_project_update, mutation: Mutations::User::NoteProject::Update
    field :user_note_project_delete, mutation: Mutations::User::NoteProject::Delete

    # notes mutations
    field :user_note_create, mutation: Mutations::User::Note::Create
    field :user_note_update, mutation: Mutations::User::Note::Update
    field :user_note_delete, mutation: Mutations::User::Note::Delete

    # notes mutations
    field :user_task_create, mutation: Mutations::User::Task::Create
    field :user_task_update, mutation: Mutations::User::Task::Update
    field :user_task_delete, mutation: Mutations::User::Task::Delete
  end
end
