require "./spec_helper"

describe CssMinifier do
  it "performs basic minification of css" do
    css = "body { background-color: black; } a:hover { opacity: 0.8 }"
    CssMinifier.minify!(css).should eq "body{background-color:#000}a:hover{opacity:.8}"
  end
end
