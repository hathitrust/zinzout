require "bundler/setup"
require "zinzout"
require 'pathname'
require 'tempfile'

HERE = Pathname.new(__dir__)
def datafilename(name)
  (HERE + 'data' + name).to_s
end

def tempfile_pair
  tf = Tempfile.new
  path = tf.path
  tf.close
  [path, path + '.gz']
end

def plain
  datafilename('plain.txt')
end

def gzipped
  datafilename('plain.txt.gz')
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
