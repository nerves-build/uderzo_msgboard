defmodule MsgBoard.Engine do
  @moduledoc """
  Run the MsgBoard.
  """

  def start_link(args \\ []) do
    [width: w, height: h] = Application.get_env(:msg_board, :dimensions)
      |> IO.inspect
  
    Uderzo.GenRenderer.start_link(__MODULE__, "MsgBoard", w, h, 1, args)
  end

  def init_renderer(state) do
    MsgBoard.Panel.init()
    {:ok, state}
  end

  def set_text(new_text) do
    Uderzo.GenRenderer.set_user_state(%{text: new_text})
    :ok
  end

  def render_frame(win_width, win_height, _mx, _my, state) do
    MsgBoard.Panel.render(win_width, win_height, state)
    {:ok, state}
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def make_env() do
    erl_env =
      case System.get_env("ERL_EI_INCLUDE_DIR") do
        nil ->
          %{
            "ERL_EI_INCLUDE_DIR" => "#{:code.root_dir()}/usr/include",
            "ERL_EI_LIBDIR" => "#{:code.root_dir()}/usr/lib"
          }

        _ ->
          %{}
      end

    erl_env
    |> Map.put("MIX_ENV", "#{Mix.env()}")
    |> Map.put("CLIXIR_DIR", Mix.Project.build_path() <> "/lib/clixir/priv")
    |> Map.put("UDERZO_DIR", Mix.Project.build_path() <> "/lib/uderzo/priv")
  end
end
