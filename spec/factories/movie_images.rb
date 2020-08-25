# frozen_string_literal: true

# == Schema Information
#
# Table name: movie_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#

FactoryBot.define do
  factory :movie_image do
    transient do
      with_file { true }
    end

    movie

    after(:build) do |movie_image, evaluator|
      if evaluator.with_file
        movie_image.file = Rack::Test::UploadedFile.new(
          Rails.root.join('spec', 'fixtures', "#{rand(1..4)}.jpg"),
          'image/png'
        )
      end
    end
  end
end
