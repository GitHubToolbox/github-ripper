#
# Class level docs
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        def display_table?(error_count, options)
            debug(options, "Function: #{__method__}")

            # Dry run - force display of all
            return true if flag_set?(options, :dry_run)

            # Quite / Silent - show nothing
            return false if flag_set?(options, :quiet) || flag_set?(options, :silent)

            # Errors or full report wanted
            return true if error_count.positive? || flag_set?(options, :full_report)

            # If in doubt say nothing
            false
        end

        #
        # This method smells of :reek:LongParameterList, :reek:DuplicateMethodCall
        #
        def draw_report(results, repo_count, error_count, options)
            debug(options, "Function: #{__method__}")

            return unless display_table?(error_count, options)

            table = create_table
            table = add_title(table, repo_count, error_count, options)
            table = add_rows(table, results, options)
            display_table(table)
        end
    end
end
