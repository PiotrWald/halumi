require 'active_support/core_ext/class/attribute.rb'
require 'active_record'
require 'dry-struct'

# Load all ruby source files
Dir['./**/*.rb'].each { |f| require f }
