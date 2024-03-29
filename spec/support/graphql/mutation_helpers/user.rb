# frozen_string_literal: true

module GraphQL
  module MutationHelpers
    def user_signup_mutation
      %(
        mutation userSignUp($input: UserSignUpInput!) {
          userSignUp(input: $input) {
            access
            csrf
            refresh
          }
        }
      )
    end

    def user_signin_mutation
      %(
        mutation userSignIn($input: UserSignInInput!) {
          userSignIn(input: $input) {
            access
            csrf
            refresh
          }
        }
      )
    end

    def signout_mutation
      %(
        mutation userSignOut {
          userSignOut {
            completed
          }
        }
      )
    end

    def refresh_token_mutation
      %(
        mutation {
          refreshToken {
            csrf
            access
            accessExpiresAt
          }
        }
      )
    end
  end
end
