if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("rle.exs", __DIR__)
end

ExUnit.start
ExUnit.configure exclude: :pending, trace: false

defmodule RunLengthEncoderTest do
  use ExUnit.Case

  test "encode for spaces" do
    assert RunLengthEncoder.encode("aabc dddef") === "2abc 3def"
  end

  test "encode for multiple spaces" do
    assert RunLengthEncoder.encode("aabc aabc  dddef") === "2abc 2abc  3def"
  end

  test "encode empty string" do
    assert RunLengthEncoder.encode("") === ""
  end

  test "encode single characters only" do
    assert RunLengthEncoder.encode("XYZ") === "XYZ"
  end

  @tag :pending
  test "decode empty string" do
    assert RunLengthEncoder.decode("") === ""
  end

  @tag :pending
  test "decode single characters only" do
    assert RunLengthEncoder.decode("XYZ") === "XYZ"
  end

  test "encode simple" do
    assert RunLengthEncoder.encode("AABBBCCCC") == "2A3B4C"
  end

  @tag :pending
  test "decode simple" do
    assert RunLengthEncoder.decode("2A3B4C") == "AABBBCCCC"
  end

  test "encode with single values" do
    assert RunLengthEncoder.encode("WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB") === "12WB12W3B24WB"
  end

  @tag :pending
  test "decode with single values" do
    assert RunLengthEncoder.decode("12WB12W3B24WB") === "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
  end

  @tag :pending
  test "decode(encode(...)) combination" do
    original = "zzz ZZ  zZ"
    encoded = RunLengthEncoder.encode(original)
    assert RunLengthEncoder.decode(encoded) === original
  end
end