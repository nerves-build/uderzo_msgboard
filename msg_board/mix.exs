defmodule MsgBoard.MixProject do
  use Mix.Project

  def project do
    [
      app: :msg_board,
      version: "0.1.0",
      elixir: "~> 1.7",
      make_env: &MsgBoard.Engine.make_env/0,               # <- add this line
      compilers: Mix.compilers() ++ [:clixir, :elixir_make],      # <- add this line
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MsgBoard.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:uderzo, "~> 0.8.0"},            # <- add this line
    ]
  end
end
