#
# Class docs to go here
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        def function_wrapper(function, options)
            begin
                results = GithubListerCore.send(function, options)
            rescue GithubListerCore::UnknownError, GithubListerCore::InvalidTokenError, GithubListerCore::MissingTokenError, GithubListerCore::TooManyRequests, GithubListerCore::NotFoundError, GithubListerCore::MissingOrganisationError, GithubListerCore::InvalidOptionsHashError => exception
                raise StandardError.new(exception.to_s)
            end
            results || []
        end
    end
end
