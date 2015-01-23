# https://github.com/kitsched/japr

require 'japr'

# # Not using compression, yui-compressor requires Java :(
# module JAPR
# 	class CssCompressor < JAPR::Compressor
# 		require 'yui/compressor'
#
# 		def self.filetype
# 			'.css'
# 		end
#
# 		def compress
# 			return YUI::CssCompressor.new.compress(@content)
# 		end
# 	end
#
# 	class JavaScriptCompressor < JAPR::Compressor
# 		require 'yui/compressor'
#
# 		def self.filetype
# 			'.js'
# 		end
#
# 		def compress
# 			return YUI::JavaScriptCompressor.new(munge: true).compress(@content)
# 		end
# 	end
# end
