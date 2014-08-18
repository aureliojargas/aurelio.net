# _plugins/txt2tags_converter.rb

module Jekyll
	class Txt2tagsConverter < Converter
		safe true
		priority :low

		def matches(ext)
			ext =~ /^\.t2t$/i
		end

		def output_ext(ext)
			".html"
		end

		def convert(content)

			# Save post text (no Front Matter) to a temporary file, and run
			# txt2tags against it. KISS
			#
			# Note: added a leading blank line to mean "Empty Headers".
			# http://txt2tags.org/userguide/HeaderArea.html

			tmpfile = '/tmp/jekyll.t2t'
			File.open(tmpfile, 'w') { |f| f.write("\n" + content) }
			`txt2tags-2.6.1102 -t html5 --no-headers --css-sugar -i #{tmpfile} -o -`
		end
	end
end
