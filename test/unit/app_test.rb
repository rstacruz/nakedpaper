require File.expand_path("../../story_helper", __FILE__)

class AppTest < UnitTest
  describe "PageHelpers" do
    setup do
      @helpers = Object.new
      @helpers.extend Main::PageHelpers
    end
    
    test "#pane_class" do
      @helpers.pane_class 'lol'
      @helpers.pane_class 'ya'
      assert @helpers.pane_class == 'lol ya'
    end
  end
end
