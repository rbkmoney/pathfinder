defmodule NewWay.Macro.EnumType do
  defmacro defenum(enum_name, allowed_values) when is_list(allowed_values) do
    quote do
      defmodule unquote(enum_name) do
        use Ecto.Type

        def type, do: :string
        def cast(term), do: NewWay.Macro.EnumType.cast(term, valid_values())
        def load(term), do: NewWay.Macro.EnumType.load(term, valid_values())
        def dump(term), do: NewWay.Macro.EnumType.dump(term, valid_values())

        defp valid_values(), do: unquote(allowed_values)
      end
    end
  end

  @spec cast(binary | atom, [atom]) :: {:ok, atom} | :error
  def cast(string, allowed_values) when is_binary(string) do
    encode(string, allowed_values)
  end
  def cast(atom, allowed_values) when is_atom(atom) do
    if Enum.member?(allowed_values, atom) do
      {:ok, atom}
    else
      :error
    end
  end
  def cast(_, _), do: :error

  @spec load(binary, [atom]) :: {:ok, atom} | :error
  def load(string, allowed_values) when is_binary(string) do
    encode(string, allowed_values)
  end
  def load(_, _), do: :error

  @spec dump(atom, [atom]) :: {:ok, binary} | :error
  def dump(atom, allowed_values) when is_atom(atom) do
    decode(atom, allowed_values)
  end
  def dump(_, _), do: :error

  @spec encode(binary, [atom]) :: {:ok, atom} | :error
  defp encode(string, allowed_values) do
    atom = String.to_atom(string)

    if Enum.member?(allowed_values, atom) do
      {:ok, atom}
    else
      :error
    end
  end

  @spec decode(atom, [atom]) :: {:ok, binary} | :error
  defp decode(atom, allowed_values) do
    if Enum.member?(allowed_values, atom) do
      {:ok, Atom.to_string(atom)}
    else
      :error
    end
  end
end
