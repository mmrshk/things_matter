# frozen_string_literal: true

module Types
  class MutationType < Types::Base::Object
    # user mutations
    field :user_sign_up, mutation: Mutations::User::SignUp
    field :user_sign_out, mutation: Mutations::User::SignOut
    field :user_sign_in, mutation: Mutations::User::SignIn

    field :refresh_token, mutation: Mutations::Auth::RefreshToken

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
    field :user_note_default, mutation: Mutations::User::Note::Default

    # task mutations
    field :user_task_create, mutation: Mutations::User::Task::Create
    field :user_task_update, mutation: Mutations::User::Task::Update
    field :user_task_delete, mutation: Mutations::User::Task::Delete

    # drag and drop

    # task
    field :move_task_in_project, mutation: Mutations::Move::Task::InProject
    field :move_task_within_project, mutation: Mutations::Move::Task::WithinProject

    # note
    field :move_note_in_project, mutation: Mutations::Move::Note::InProject
    field :move_note_within_project, mutation: Mutations::Move::Note::WithinProject

    # project
    field :move_project_in_area, mutation: Mutations::Move::Project::InArea
    field :move_project_within_area, mutation: Mutations::Move::Project::WithinArea

    # area
    field :move_area_within_areas, mutation: Mutations::Move::Area::WithinArea
  end
end
