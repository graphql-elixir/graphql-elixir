defmodule GraphQL do
  @moduledoc ~S"""
  The main GraphQL module.

  The `GraphQL` module provides a
  [GraphQL](http://facebook.github.io/graphql/) implementation for Elixir.

  ## Execute a query

  Execute a GraphQL query against a given schema / datastore.

      # iex> GraphQL.execute schema, "{ hello }"
      # {:ok, %{hello: "world"}}
  """

  defmodule ObjectType do
    defstruct name: "RootQueryType", description: "", fields: %{}
  end

  defmodule FieldDefinition do
    defstruct name: nil, type: "String", args: %{}, resolve: nil
  end

  @doc """
  Execute a query against a schema.

      # iex> GraphQL.execute(schema, "{ hello }")
      # {:ok, %{hello: world}}
  """
  def execute(schema, query, root_value \\ %{}, variable_values \\ %{}, operation_name \\ nil) do
    {:ok, document} = GraphQL.Lang.Parser.parse(query)
    GraphQL.Execution.Executor.execute(schema, document, root_value, variable_values, operation_name)
  end
end
