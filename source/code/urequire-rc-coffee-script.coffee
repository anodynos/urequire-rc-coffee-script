coffee = require 'coffee-script'
coffeeExtensions =   /.*\.(coffee\.md|litcoffee|coffee)$/ # RexExp for all coffeescript extensions

# This RC is using an [] instead of {}. Key names of RC are assumed from their posision in the array:
module.exports = [
    '$coffee-script' # `name` & flags as a String at pos 0

    "'coffee-script' compiler." # `descr` at pos 1

    [ '**/*.coffee', /.*\.(coffee\.md|litcoffee)$/i] # `filez` [] at pos 2

    (m)-> coffee.compile m.converted, @options  # `convert` Function at pos 3

    (srcFn)-> # `convFilename` Function at pos 4
      # retrieve matched extension
      ext = srcFn.replace coffeeExtensions , "$1"
      # replace it and return new filename
      srcFn.replace (new RegExp ext+'$'), 'js'

    {bare: false} # the default options object. If convFilename is absent, it can take its place.
  ]