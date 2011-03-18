class Main
  module PageHelpers
    def body_class(v = nil)
      @body_classes ||= []
      @body_classes << v  if v

      @body_classes.join(' ')
    end

    def area_class(v = nil)
      @area_classes ||= []
      @area_classes << v  if v

      @area_classes.join(' ')
    end

    def title(title=nil)
      @page_title = title  if title
      @page_title
    end

    def extends(what)
      partial what
    end
  end

  helpers PageHelpers
end
