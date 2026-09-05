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
#   Plugin:   <figure><img src="http://example.com/image.jpg" alt=""></figure>
#
# The same happens for images with no caption, but surrounded by a link.
#
#   Markdown: [![](http://example.com/image.jpg)](http://example.com)
#   HTML:     <p><a href="http://example.com"><img src="http://example.com/image.jpg" alt=""></a></p>
#   Plugin:   <figure><a href="http://example.com"><img src="http://example.com/image.jpg" alt=""></a></figure>
#
# Images with caption are marked with the <figure> tag.
#
#   Markdown: ![caption1](http://example.com/image.jpg)
#   HTML:     <p><img src="http://example.com/image.jpg" alt="caption1"></p>
#   Plugin:   <figure><img src="http://example.com/image.jpg" alt="caption1"><figcaption>caption1</figcaption></figure>
#
# Also works for images with caption and surrounded by a link.
#
#   Markdown: [![caption2](http://example.com/image.jpg)](http://example.com)
#   HTML:     <p><a href="http://example.com"><img src="http://example.com/image.jpg" alt="caption2"></a></p>
#   Plugin:   <figure><a href="http://example.com"><img src="http://example.com/image.jpg" alt="caption2"></a><figcaption>caption2</figcaption></figure>

module Jekyll
	module ImgcaptionFilter
		def imgcaption(input)

			# We only act on Markdown files, skip others (e.g., HTML)
			current_page = @context.registers[:page]
			return input unless current_page && current_page['path'] && current_page['path'].end_with?('.md')

			input.gsub(
				/<p>(<img src=".+?" alt="")( \/)?><\/p>/,
				'<figure>\1 /></figure>'
			).gsub(
				/<p>(<a href=".*?"><img src=".+?" alt="")( \/)?><\/a><\/p>/,
				'<figure>\1 /></a></figure>'
			).gsub(
				/<p>(<img src=".+?" alt="(.+)")( \/)?><\/p>/,
				'<figure>\1 /><figcaption>\2</figcaption></figure>'
			).gsub(
				/<p>(<a href=".*?"><img src=".+?" alt="(.+)")( \/)?><\/a><\/p>/,
				'<figure>\1 /></a><figcaption>\2</figcaption></figure>'
			)
		end
	end
end

Liquid::Template.register_filter(Jekyll::ImgcaptionFilter)
