defmodule MsgBoard.Panel do
  @moduledoc """
  This modules draws the MsgBoard message
  """
  use Clixir
  require Logger

  @clixir_header "msg_board"

  def init() do
    create_font("Prociono", font_path("Prociono.ttf"))
  end

  def render(win_width, win_height, %{text: text}) do
    setup_screen(win_width, win_height)
    setup_font("Prociono")

    draw_centered_text(text, String.length(text), 150.0, win_width)
  end

  def font_path(font_name) do
    base_dir = Application.app_dir(:msg_board, ".")
    priv_dir = Path.absname("priv", base_dir)
    Path.join(priv_dir, font_name)
  end

  def_c setup_screen(win_width, win_height) do
    cdecl(double: win_width)
    cdecl(double: win_height)

    nvgReset(vg)
    nvgBeginPath(vg)
    nvgRect(vg, 2, 2, win_width - 4.0, win_height - 4.0)
    nvgFillColor(vg, nvgRGBA(0, 0, 0, 255))
    nvgFill(vg)
  end

  def_c draw_centered_text(text, text_length, font_size, width) do
    cdecl("char *": text)
    cdecl(double: width)
    cdecl(long: text_length)
    cdecl(double: font_size)

    nvgFontSize(vg, font_size)
    nvgTextAlign(vg, NVG_ALIGN_CENTER | NVG_ALIGN_TOP)
    nvgTextBox(vg, 0.0, 0.0, width, text, text + text_length)
  end

  def_c create_font(name, file_name) do
    cdecl("char *": [name, file_name])

    assert(nvgCreateFont(vg, name, file_name) >= 0)
  end

  def_c setup_font(font_name) do
    cdecl("char *": font_name)
    nvgFontFace(vg, font_name)
    nvgFillColor(vg, nvgRGBA(255, 255, 255, 255))
  end
end
