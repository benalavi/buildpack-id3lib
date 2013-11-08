unless ENV["HEROKU_API_KEY"]
  warn "Set HEROKU_API_KEY to your heroku API key (heroku auth:token) (https://github.com/heroku/hatchet)"
  exit 10
end

require "minitest/autorun"
require "hatchet"

class ID3LibTest < MiniTest::Unit::TestCase
  def test_id3lib_headers_are_available_to_build_id3lib_ruby
    # FIXME: Using Hatchet::Runner just because of the way it sets up Anvil for
    # us, not because we actually need the app to do anything -- should find a
    # less hacky way to do it, or use Anvil directly, or something...
    Hatchet::Runner.new("id3lib").deploy do |app|
      assert_match /Successfully installed id3lib-ruby-0.6.0/, app.run("gem install id3lib-ruby -n /tmp/id3lib-ruby -i /tmp/id3lib-ruby")
    end
  end
end
