# frozen_string_literal: true

FactoryBot.define do
  factory :note_image do
    note

    before(:create) do |note_image, _evaluator|
      note_image.file = Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', "#{rand(1..4)}.jpg"),
        'image/png'
      )
    end
  end
end
