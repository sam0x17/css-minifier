require "duktape"
require "./clean-css"

module CssMinifier
  def self.initialize_context
    ctx = Duktape::Sandbox.new
    ctx.eval!(CLEAN_CSS_JS)
    ctx
  end
  @@ctx : Duktape::Sandbox = initialize_context

  def self.minify!(source : String)
    source = source.gsub("\"", "\\\"")
    source = source.gsub("\n", "\\n")
    source = source.gsub("'", "\\'")
    @@ctx.eval!("var output = new CleanCSS({}).minify(\'#{source}\');")
    @@ctx.eval!("output.styles")
    output = @@ctx.get_string(-1)
  end
end
