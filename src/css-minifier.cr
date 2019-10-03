require "duktape"
require "./clean-css"

module CssMinifier
  def self.initialize_context
    ctx = Duktape::Sandbox.new
    ctx.eval!(CLEAN_CSS_JS)
    ctx
  end
  @@ctx : Duktape::Sandbox? = nil

  def self.minify!(source : String)
    @@ctx ||= initialize_context
    ctx = @@ctx.not_nil!
    source = source.gsub("\"", "\\\"")
    source = source.gsub("\n", "\\n")
    source = source.gsub("'", "\\'")
    ctx.eval!("var output = new CleanCSS({}).minify(\'#{source}\');")
    ctx.eval!("output.styles")
    output = ctx.get_string(-1).not_nil!
    ctx.eval!("JSON.stringify(output.errors)")
    errors = ctx.get_string(-1).not_nil!
    raise errors if errors != "[]"
    output
  end
end
