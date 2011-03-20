require File.expand_path("../../story_helper", __FILE__)

class SiteTest < StoryTest
  test "hello" do
    visit '/'
    assert current_path == '/login'
  end

  test "login" do
    login!
  end
end
