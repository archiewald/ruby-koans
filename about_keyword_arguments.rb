require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, "two"], method_with_keyword_arguments
    assert_equal ["one", "two"], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    assert_match(/wrong number of arguments/, exception.message)
  end

  # THINK ABOUT IT:
  #
  # Keyword arguments always have a default value, making them optional to the caller
  # 
  # Actually... NO! https://thoughtbot.com/blog/ruby-2-keyword-arguments
  # Ruby 2.1 introduced required keyword arguments, which are defined with a trailing colon

  def method_with_required_keyword_argument(bar:)
    bar
  end

  def test_required_keyword_argument
    assert_equal 1, method_with_required_keyword_argument(bar: 1)
    assert_raise(ArgumentError) do
      method_with_required_keyword_argument
    end
  end
end
