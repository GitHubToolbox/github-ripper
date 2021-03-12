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
            rescue UnknownError, InvalidTokenError, MissingTokenError, TooManyRequests, NotFoundError, MissingOrganisationError, InvalidOptionsHashError => exception
                raise StandardError.new(exception.to_s)
            end
            results || []
        end
    end
end
