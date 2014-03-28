# Author: Aurelio Jargas, 2013-10-27
#
# Adds extra markup to Markdown images which are solo in a paragraph.
#
# Usage: {{ content | imgcaption }}
#
# Images with no caption (alt="" attribute) are just marked with an 'image' class.
#
#   Markdown: ![](http://example.com/image.jpg)
#   HTML:     <p><img src="http://example.com/image.jpg" alt=""></p>
#   Plugin:   <p class="image"><img src="http://example.com/image.jpg" alt=""></p>
#
# The same happens for images with no caption, but surrounded by a link.
#
#   Markdown: [![](http://example.com/image.jpg)](http://example.com)
#   HTML:     <p><a href="http://example.com"><img src="http://example.com/image.jpg" alt=""></a></p>
#   Plugin:   <p class="image"><a href="http://example.com"><img src="http://example.com/image.jpg" alt=""></a></p>
#
# Images with caption are marked with 'figure' class and the caption is placed inside a <span> tag.
#
#   Markdown: ![caption1](http://example.com/image.jpg)
#   HTML:     <p><img src="http://example.com/image.jpg" alt="caption1"></p>
#   Plugin:   <p class="figure"><img src="http://example.com/image.jpg" alt="caption1"><span>caption1</span></p>
#
# Also works for images with caption and surrounded by a link.
#
#   Markdown: [![caption2](http://example.com/image.jpg)](http://example.com)
#   HTML:     <p><a href="http://example.com"><img src="http://example.com/image.jpg" alt="caption2"></a></p>
#   Plugin:   <p class="figure"><a href="http://example.com"><img src="http://example.com/image.jpg" alt="caption2"></a><span>caption2</span></p>

module Jekyll
	module ImgcaptionFilter
		def imgcaption(input)
			input.gsub(
				/<p>(<img src=".+?" alt="">)<\/p>/,
				'<p class="image">\1</p>'
			).gsub(
				/<p>(<a href=".*?"><img src=".+?" alt=""><\/a>)<\/p>/,
				'<p class="image">\1</p>'
			).gsub(
				/<p>(<img src=".+?" alt="(.+)">)<\/p>/,
				'<p class="figure">\1<span>\2</span></p>'
			).gsub(
				/<p>(<a href=".*?"><img src=".+?" alt="(.+)"><\/a>)<\/p>/,
				'<p class="figure">\1<span>\2</span></p>'
			)
		end
	end
end

Liquid::Template.register_filter(Jekyll::ImgcaptionFilter)
