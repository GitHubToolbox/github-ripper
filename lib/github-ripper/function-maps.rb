#
# Class docs
#
class GithubRipper
    #
    # Lookup the github-lister-core function from the options given
    #
    FUNCTION_MAP = {
        :user_repos        => 'user_repos',
        :org_repos         => 'org_repos',
        :org_members_repos => 'org_members_repos',
        :all_repos         => 'all_repos'
    }.freeze

    class << self
        #
        # Everything below here is private
        #

        private

        def function_map_lookup(options)
            return FUNCTION_MAP[:user_repos] if flag_set?(options, :user_repos) || get_option(options, :user)
            return FUNCTION_MAP[:org_members_repos] if flag_set?(options, :org_members_repos)
            return FUNCTION_MAP[:all_repos] if flag_set?(options, :all_repos)
            return FUNCTION_MAP[:org_repos] if flag_set?(options, :org_repos) || get_option(options, :org)

            nil
        end
    end
end
