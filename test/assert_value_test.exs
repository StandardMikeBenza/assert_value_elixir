defmodule AssertValueTest do
  use ExUnit.Case
  doctest AssertValue
  import AssertValue

  test "text_diff char lists" do
    a = '''
    aaa
    bbb
    ccc
    ddd
    eee
    fff
    '''
    b = '''
    aaa
    xxx
    ddd
    eee
    fff
    GGG
    '''
    assert AssertValue.diff(a, b) == '''
     aaa
    -bbb
    -ccc
    +xxx
     ddd
     eee
     fff
    +GGG
    '''
  end

  test "text_diff strings" do
    a = "aaa\nbbb\nccc\nddd\neee\nfff\n"
    b = "aaa\nxxx\nddd\neee\nfff\nGGG\n"
    assert AssertValue.diff(a, b) == '''
     aaa
    -bbb
    -ccc
    +xxx
     ddd
     eee
     fff
    +GGG
    '''
  end

  test "prototype pass" do
    actual = '''
    aaa
    bbb
    '''
    assert_value actual == '''
    aaa
    bbb
    '''
  end

  test "prototype fail" do
    actual = '''
    aaa
    bbb
    ccc
    ddd
    eee
    fff
    '''
    assert_value actual == "111"
  end

  test "prototype fail 2" do
    actual = '''
    aaa
    bbb
    ccc
    ddd
    eee
    fff
    '''
    assert_value actual == '''
    asdasda
    '''
  end

  test "prototype with file" do
    actual = '''
    aaa
    bbb
    ccc
    ddd
    eee
    fff
    '''
    assert_value actual == File.read!(__DIR__ <> "/data.txt")
  end

  test "test unknown argument" do
    assert_raise RuntimeError, "Unknown argument type: :atom", fn ->
      actual = 'abc'
      assert_value actual == :atom
    end
  end



end
