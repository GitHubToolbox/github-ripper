#
# Class docs to go here
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        #
        # This method smells of :reek:DuplicateMethodCall
        #
        def set_colour(item, status)
            return Rainbow(item).yellow if item.downcase == 'dry run'

            case status.downcase
            when 'dry run'
                Rainbow(item).cyan
            when 'failed'
                Rainbow(item).red
            else
                Rainbow(item).green
            end
        end

        # This method smells :reek:UtilityFunction, :reek:ControlParameter
        def plural(count, singular, plural = nil)
            if count == 1
                singular.to_s
            elsif plural
                plural.to_s
            else
                "#{singular}s"
            end
        end

        # This method smells of :reek:UtilityFunction
        def count_repos(results)
            results.size
        end

        # This method smells of :reek:UtilityFunction
        def count_errors(results)
            results.select { |repo| repo[:status] == 'Failed' }.size
        end

        # This method smells of :reek:UtilityFunction
        def filter_results(results, options)
            results.select { |repo| repo[:status] == 'Failed' || flag_set?(options, :full_report) || flag_set?(options, :dry_run) }.sort_by { |repo| repo[:repo].downcase }
        end

        def get_option(options, name)
            options[name] if options.key?(name)
        end

        def flag_set?(options, name)
            return true if options.key?(name) && options[name] == true

            false
        end
    end
end
