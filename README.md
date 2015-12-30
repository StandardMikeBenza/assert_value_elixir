# assert_value

Checks that two values are same and "magically" replaces expected value
with the actual in case the new behavior (and new actual value) is correct.

For now supports two kind of expected arguments: string heredocs or files


## Installation

Add AssertValue as a test env dependency to your Mix project

```elixir
defp deps do
  [{:assert_value, git: "git@github.com:acunote/assert_value_elixir.git"}, only: :test]
end
```
AssertValue needs its internal application to work. Since we compile AssertValue
for test env only we need to start it manually. Add the following line to test/test_helper.exs

```elixir
AssertValue.App.start(:normal, [])
```

## Usage

### Testing String Values

It is better to start with no expected value

```elixir
import AssertValue

test "fresh start" do
  assert_value "foo"
end
```
Then run your tests as usual with "mix test".
As a result you will see diff between expected and actual values:
```
<Failed Assertion Message>
    "foo"

-
+foo

Accept new value [y/n]?
```
If you accept the new value your test will be automatically modified to
```elixir
test "fresh start" do
  assert_value "foo" == """
  foo
  """
end
```

## License

This software is licensed under [the MIT license](LICENSE).
