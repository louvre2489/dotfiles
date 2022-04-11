local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({
    -- wezterm.font("SauceCodePro Nerd Font", {weight="Bold", stretch="Normal", style="Normal"}),
    {family="SauceCodePro Nerd Font Mono", weight="Bold", stretch="Normal", style="Normal"},
  }),
  use_ime = true, -- これがないとIMEが動かない
  font_size = 11.0,
  color_scheme = "OneHalfDark", -- テーマ：https://wezfurlong.org/wezterm/colorschemes/index.html
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
}
