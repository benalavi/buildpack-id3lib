require "minitest/autorun"
require "hatchet"

class ID3LibTest < MiniTest::Unit::TestCase
  def test_id3lib_headers_are_available_to_build_id3lib_ruby
    Hatchet::Runner.new("ruby_id3lib").deploy do |app|
      puts app.run("echo \$C_INCLUDE_PATH")
      puts app.run("echo \$CPLUS_INCLUDE_PATH")
      puts app.run("gem --version")
      puts app.run("mkdir -p /tmp/id3lib-ruby && gem install id3lib-ruby -n /tmp/id3lib-ruby -i /tmp/id3lib-ruby")
    end
  end
end
