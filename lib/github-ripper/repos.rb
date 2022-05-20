#
# Class docs to go here
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        # rubocop:disable Metrics/CyclomaticComplexity
        # This method smells of :reek:NilCheck
        def handle_required_parameters(options)
            debug(options, "Function: #{__method__}")

            return if get_option(options, :token)

            raise StandardError.new('Please supply a username (-u) or a token (-t)') if (flag_set?(options, :user_repos) || flag_set?(options, :org_members_repos) || flag_set?(options, :all_repos)) && get_option(options, :user).nil?

            raise StandardError.new('Please supply an organisation name (-o) or a token (-t)') if flag_set?(options, :org_repos) && get_option(options, :org).nil?
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        #
        # docs go here
        #
        def get_repo_list(options)
            debug(options, "Function: #{__method__}")

            handle_required_parameters(options)

            function = function_map_lookup(options)

            raise StandardError.new('Missing parameters') unless function

            JSON.parse(function_wrapper(function, options))
        end

        #
        # This method smells of :reek:DuplicateMethodCall
        #
        def rip_repos(options, repos)
            debug(options, "Function: #{__method__}")

            repo_count = repos.size

            results = if flag_set?(options, :silent)
                          Parallel.map(repos) { |repo| clone_repo_wrapper(options, repo) }
                      else
                          Parallel.map(repos, :progress => "Cloning #{repo_count}") { |repo| clone_repo_wrapper(options, repo) }
                      end
            results.compact
        end

        def process_results(results, options)
            debug(options, "Function: #{__method__}")

            repo_count = count_repos(results)
            error_count = count_errors(results)
            results = filter_results(results, options)
            [results, repo_count, error_count]
        end
    end
end
