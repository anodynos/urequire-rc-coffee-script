coffee = require 'coffee-script'
coffeeExtensions =   /.*\.(coffee\.md|litcoffee|coffee)$/ # RexExp for all coffeescript extensions
literateExtensions = /.*\.(coffee\.md|litcoffee)$/i

# This RC is using an [] instead of {}. Key names of RC are assumed from their posision in the array:
module.exports = [
    '$coffee-script' # `name` & flags as a String at pos 0

    "'coffee-script' compiler." # `descr` at pos 1

    [ coffeeExtensions ] # `filez` [] at pos 2

    (m)->
      if m.srcFilename.match literateExtensions
        @options.literate = true
        converted = coffee.compile m.converted, @options  # `convert` Function at pos 3
        @options.literate = false
      else
        converted = coffee.compile m.converted, @options  # `convert` Function at pos 3

      converted

    (srcFn)-> # `convFilename` Function at pos 4
      # retrieve matched extension
      ext = srcFn.replace coffeeExtensions , "$1"
      # replace it and return new filename
      srcFn.replace (new RegExp ext+'$'), 'js'

    {bare: false} # the default options object. If convFilename is absent, it can take its place.
  ]