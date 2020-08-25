# frozen_string_literal: true

if Rails.env.development?
  UserProfile.delete_all
  UserAccount.delete_all
  Movie.delete_all

  FactoryBot.create(
    :user_account,
    email: 'user@example.com',
    password: 'password',
    with_user_profile: true,
    with_custom_lists: true,
    with_favorite_movies: true,
    with_watchlist_movies: true
  )

  FactoryBot.create_list(:movie, 10, with_poster: true, with_movie_images: true)
  FactoryBot.create_list(:movie, 10, with_poster: true)
  FactoryBot.create_list(:movie, 10)
end
