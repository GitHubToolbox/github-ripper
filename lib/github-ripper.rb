require 'fileutils'
require 'github-lister-core'
require 'json'
require 'open3'
require 'rainbow'
require 'terminal-table'

require_relative 'github-ripper/function-maps'
require_relative 'github-ripper/git'
require_relative 'github-ripper/report'
require_relative 'github-ripper/repos'
require_relative 'github-ripper/table'
require_relative 'github-ripper/utils'
require_relative 'github-ripper/version'
require_relative 'github-ripper/wrapper'

#
# Class level docs
#
class GithubRipper
    class << self
        #
        # Do something ...
        #
        def rip(options = {})
            # The following is to force github-lister-core to only retun repo slugs
            options[:use_slugs] = true
            options[:base_dir] = "#{File.expand_path('~')}/Downloads/Repos" unless get_option(options, :base_dir)

            repos = get_repo_list(options)
            results = rip_repos(options, repos)

            results, repo_count, error_count = process_results(results, options)
            draw_report(results, repo_count, error_count, options)
        end
    end
end
