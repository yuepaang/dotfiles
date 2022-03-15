lua << EOF

package.loaded["config.colorscheme.onedark"] = nil
package.loaded["config.colorscheme.onedark.base"] = nil
package.loaded["config.colorscheme.onedark.treesitter"] = nil
package.loaded["config.colorscheme.onedark.lsp"] = nil
package.loaded["config.colorscheme.onedark.others"] = nil

require("config.colorscheme.onedark")

EOF
