ExUnit.configure(exclude: [skip: true])
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Microblog.Repo, :manual)

