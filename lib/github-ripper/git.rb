#
# Class docs to go here
#

#
# This class smells of :reek:DataClump
#
class GithubRipper
    class << self
        #
        # Everything below here is private
        #

        private

        def get_clone_type(options)
            return 'git clone git@github.com:' if flag_set?(options, :use_git)

            return "git clone https://#{options[:token]}@github.com/" if get_option(options, :token)

            'git clone https://github.com/'
        end

        def repo_full_path(options, repo)
            "#{options[:base_dir]}/#{repo}"
        end

        def repo_exists?(repo_path)
            File.directory?(repo_path)
        end

        def execute_command(command)
            error_string = ''
            return_code = 0

            Open3.popen3(command) do |_stdin, stdout, _stderr, wait_thr|
                error_string = stdout.read.chomp.to_s
                return_code = wait_thr.value.exitstatus
            end
            output = error_string.split(/\n+/).reject(&:empty?).join(', ')
            [return_code, output]
        end

        def clone_repo(options, repo, repo_path)
            return { :repo => repo, :path => repo_path, :status => 'Dry Run', :when => 'git clone', :info => '' } if flag_set?(options, :dry_run)

            FileUtils.mkdir_p repo_path

            clone_type = get_clone_type(options)
            command = "#{clone_type}#{repo} #{repo_path}"
            return_code, output = execute_command(command)

            return { :repo => repo, :path => repo_path, :status => 'Failed', :when => 'git clone', :info => output } if return_code.positive?

            { :repo => repo, :path => repo_path, :status => 'Success', :when => 'git clone', :info => 'Clone Succeeded' }
        end

        def update_repo(options, repo, repo_path)
            return { :repo => repo, :path => repo_path, :status => 'Dry Run', :when => 'git clone', :info => '' } if flag_set?(options, :dry_run)

            olddir = Dir.pwd
            Dir.chdir repo_path

            command = 'git pull 2>&1'
            return_code, output = execute_command(command)
            Dir.chdir olddir

            return { :repo => repo, :path => repo_path, :status => 'Failed', :when => 'git pull', :info => output } if return_code.positive?

            { :repo => repo, :path => repo_path, :status => 'Success', :when => 'git pull', :info => 'Pull Succeeded' }
        end

        def clone_repo_wrapper(options, repo)
            repo_path = repo_full_path(options, repo)

            return update_repo(options, repo, repo_path) if repo_exists?(repo_path)

            clone_repo(options, repo, repo_path)
        end
    end
end
