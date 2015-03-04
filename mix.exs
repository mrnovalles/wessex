defmodule GameSession.Mixfile do
  use Mix.Project

  def project do
    [app: :wessex,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:cowboy, :plug, :wes],
     mod: {WessEx, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  def deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 0.9.0"},
     {:jazz, github: "meh/jazz" },
     {:wes, github: "zucaritask/wes" }]
  end
end
