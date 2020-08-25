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

class MovieImage < ApplicationRecord
  belongs_to :movie

  has_one_attached :file
end
