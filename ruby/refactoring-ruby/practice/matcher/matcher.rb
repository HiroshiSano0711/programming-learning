class Matcher
  def match(expected, actual, clip_limit, delta) 
    # Clip "too-large" values
    actual = clip_too_large_values(actual, clip_limit)

    # Check for length differences
    return false if actual.length != expected.length

    # Check that each entry is within expected +/- delta
    actual.each_index { |i|
      return false if (expected[i] - actual[i]).abs > delta
    }
    return true
  end
end
