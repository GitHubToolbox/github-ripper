lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'github-ripper/version'

Gem::Specification.new do |spec|
    spec.name          = 'github-ripper'
    spec.version       = GithubRipper::VERSION
    spec.authors       = ['Tim Gurney aka Wolf']
    spec.email         = ['wolf@tgwolf.com']

    spec.summary       = 'Ghrip is a command line tool for ripping (cloning) repositories from GitHub in bulk.'
    spec.description   = 'Ghrip is a command line tool for ripping (cloning) repositories from GitHub in bulk. It allows you to clone all repositories owned by a named user or users, or from an organisation or organisations.'
    spec.homepage      = 'https://github.com/DevelopersToolbox/github-ripper'
    spec.license       = 'MIT'

    spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/DevelopersToolbox/github-ripper'
    spec.metadata['changelog_uri'] = 'https://github.com/DevelopersToolbox/github-ripper/blob/master/CHANGELOG.md'

    # Specify which files should be added to the gem when it is released.
    # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
    # rubocop:disable Layout/ExtraSpacing, Layout/SpaceAroundOperators
    spec.files         = Dir.chdir(File.expand_path(__dir__)) do
        `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    end
    # rubocop:enable Layout/ExtraSpacing, Layout/SpaceAroundOperators

    spec.bindir        = 'exe'
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ['lib']

    spec.add_development_dependency 'bundler', '~> 2'
    spec.add_development_dependency 'github-lister-core', '~> 0.1'
    spec.add_development_dependency 'parallel', '~> 1.2'
    spec.add_development_dependency 'rainbow', '~> 3'
    spec.add_development_dependency 'rake', '~> 12.3.3'
    spec.add_development_dependency 'rspec', '~> 3.0'
    spec.add_development_dependency 'ruby-progressbar', '~> 1'
    spec.add_development_dependency 'terminal-table', '~> 3'

    spec.add_runtime_dependency 'github-lister-core', '~> 0.1'
    spec.add_runtime_dependency 'parallel', '~> 1.2'
    spec.add_runtime_dependency 'rainbow', '~> 3'
    spec.add_runtime_dependency 'ruby-progressbar', '~> 1'
    spec.add_runtime_dependency 'terminal-table', '~> 3'
end
