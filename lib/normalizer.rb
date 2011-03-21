require 'nokogiri'

# Normalizer
#
# == Example
#   
#   Normalizer.normalize '<p>Hello</p><a>  </a><h3 style="lol">hi</h3>thth<p><img></p>'
#   Normalizer.normalize node
#
module Normalizer
  extend self

  BLOCK  = %w(p h1 h2 h3 h4 h5 h6 dl dt dd)
  INLINE = %w(a span strong em b i)

  BLACKLIST = [
    /feedburner/,
    /^http:\/\/i\.creativecommons\.org/,
    /http:\/\/api\.tweetmeme\.com/,
    /(ck|avw|adview)\.php/,
    /doubleclick\.net/,
    /\badvertisement\b/
  ]
  
  # Normalizes HTML by cleaning out common mistakes.
  def normalize(node)
    return normalize_str(node)  if node.is_a?(String)

    html = node.dup

    remove_trackers! html
    remove_blacklisted_images! html
    remove_style_attrs! html
    wrap_stray_text! html
    move_stray_images! html

    blocks(html).each do |blk|
      if block?(blk)
        add_class blk, 'short'  if blk.content.size < 50
        add_class blk, 'image'  if image_paragraph?(blk)
        handle_duplicate_brs! blk
        fix_pseudo_headings! blk
      end
    end

    blocks(html).each do |blk|
      blk.remove  if blank?(blk)  # Not recursive
    end

    html
  end

  def block?(html)
    BLOCK.include? html.name
  end

  def normalize_str(str)
    str = "<p>#{str}</p>"
    normalize(Nokogiri.HTML(str)).xpath('//body').children.to_s
  end

  def blocks(html)
    html.css((INLINE+BLOCK).join(','))
  end

  def add_class(html, cls)
    html['class'] = [html['class'], cls].compact.join(' ')
  end

  # Isolate images into their own paragraphs
  def move_stray_images!(html)
    move = lambda { |para, img|
      if para.children.index(img) == 0
        para.add_previous_sibling "<p class='image'>#{img}</p>"
        img.remove
      end
    }

    html.css('p>img:first-child').each do |img|
      move[img.parent, img]
    end
    html.css('p>a:first-child>img').each do |img|
      move[img.parent.parent, img.parent]
    end
  end

  def remove_trackers!(html)
    html.css("img[width='1'], img[height='1']").remove
  end

  def remove_blacklisted_images!(html)
    html.css('img').each do |img|
      BLACKLIST.any? do |spec|
        (img.remove && true)  if img['src'].to_s.match(spec)
      end
    end
  end

  # @example
  #   "<p><strong>hi there</strong></p>"  #=> "<h3>hi there</h3>"
  #
  def fix_pseudo_headings!(html)
    heading = html.at_css('strong, b')
    if html.children.size == 1 && heading
      html.add_next_sibling "<h3>#{heading.content}</h3>"
      html.remove
    end
  end

  # @example
  #   "<p>hi<br><br>there</p>"  #=> "<p>hi</p><p>there</p>"
  #
  def handle_duplicate_brs!(html)
    html.css('br+br').each do |br|
      i = html.children.index(br)
      next  if i.nil?

      pre, post = [ html.children[0..(i-2)], html.children[(i+1)..-1] ]

      tag = html.name
      html.add_next_sibling "<#{tag}>#{post}</#{tag}>"
      html.add_next_sibling "<#{tag}>#{pre}</#{tag}>"
      html.remove
    end

    html
  end

  # @example
  #   "<p><img></p>"        #=> true
  #   "<p>hello <img></p>"  #=> false
  #
  def image_paragraph?(html)
    paragraph_with? html, 'img, embed, iframe'
  end

  def paragraph_with?(html, selector)
    size = html.css(selector).size
    html.css('*').size == size && html.text.strip == '' && size > 0
  end

  # @example
  #   "<p>  \n</p>"   #=> true
  #
  def blank?(html)
    html.text.strip == '' && html.css('*').empty?
  end

  # @example
  #   "<a style='display:block'></a>"  # => "<a></a>"
  #
  def remove_style_attrs!(html)
    html.xpath('//@style').remove
  end

  # @example
  #   "<p>hi</p>hello"  # => "<p>hi</p><p>hello</p>"
  #
  def wrap_stray_text!(html)
    html.xpath('//body/text()').each do |text|
      text.add_next_sibling "<p>#{text}</p>"
      text.remove
    end
  end
end
