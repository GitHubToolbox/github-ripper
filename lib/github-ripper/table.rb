#
# Class level docs
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        # This method smells of :reek:UtilityFunction
        def create_table
            Terminal::Table.new :headings => ['Repo', 'Path', 'Status', 'When', 'Information']
        end

        # This method smells of :reek:ControlParameter, :reek:LongParameterList
        def add_title(table, repo_count, error_count, options)
            title = "There were #{error_count} #{plural(error_count, 'error')}"
            title += " from #{repo_count} #{plural(repo_count, 'repository', 'respositories')}" if flag_set?(options, :full_report) || flag_set?(options, :dry_run)

            table.title = title
            table
        end

        # This method smells of :reek:UtilityFunction, :reek:ControlParameter
        def visible_row?(repo, options)
            # Dry run - force display of all
            return true if flag_set?(options, :dry_run)

            repo[:status] == 'Failed' || flag_set?(options, :full_report)
        end

        def add_single_row(table, repo, options)
            status = repo[:status]
            table.add_row [set_colour(repo[:repo], status), set_colour(repo[:path], status), set_colour(status, status), set_colour(repo[:when], status), set_colour(repo[:info], status)] if visible_row?(repo, options)
            table
        end

        def add_rows(table, results, options)
            results.each { |repo| table = add_single_row(table, repo, options) }
            table
        end

        def display_table(table)
            puts table
        end
    end
end
