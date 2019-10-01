require "baked_file_system"

class CleanCss
  extend BakedFileSystem
  bake_folder "../clean-css"
end

CLEAN_CSS_JS = CleanCss.get("clean-css-v4.2.1.js").gets_to_end
