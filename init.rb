APP_ROOT = File.dirname(__FILE__)

#require "#{APP_ROOT}/lib/guide"
$:.unshift( File.join(APP_ROOT, 'lib') )
require 'guide'

g = Guide.new("Kiev.txt")
g.launch!