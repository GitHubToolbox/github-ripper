#
# Class docs to go here
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        def verbose(options, message)
            print(Rainbow("[ VERBOSE ] #{message}\n").cyan.bright) if get_option(options, :verbose)
        end

        def debug(options, message)
            print(Rainbow("[ DEBUG ] #{message}\n").yellow.bright) if get_option(options, :debug)
        end
    end
end
