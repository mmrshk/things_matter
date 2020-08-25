# frozen_string_literal: true

module Movie::Operation
  class Index < Trailblazer::Operation
    step :set_result

    def set_result(ctx, filter:, **)
      ctx['result'] = filter ? ::Movie.where('title LIKE ?', "%#{filter}%") : ::Movie.all
    end
  end
end
