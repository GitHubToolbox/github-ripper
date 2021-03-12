#!/usr/bin/env ruby
#
# This is a very simply testing script to allow for testing of local changes without having to install the gem locally
#

require 'json'

$LOAD_PATH.unshift('./lib')

require 'bundler/setup'
require 'github-ripper'

options = {}

pp GithubRipper.rip(options)
