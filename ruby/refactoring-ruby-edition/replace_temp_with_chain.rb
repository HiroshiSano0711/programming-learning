##### Replace Temp with Chain #####
# before
mock = Mock.new
expectation = mock.expects(:a_method_name)
expectation.with('arguments')
expectation.returns([1, :array])

# after
mock = Mock.new
mock.expects(:a_method_name).with('arguments').returns([1, :array])

# 関数の返り値を一時的に保持している一時変数がある。
# チェインすることで一時変数を取り除く
# チェインしたいメソッドからselfを返す
# テストする
# ローカル変数を取り除き、メソッドをチェインする

# before
class Select
  def options
    @options ||= []
  end

  def add_options(arg)
    options << arg
  end
end

select = Select.new
select.add_options(1999)
select.add_options(2000)
select.add_options(2001)
select.add_options(2002)
select # => <Select:0x28707 @options=[1999, 2000, 2001, 2002]>

# first step
class Select
  # インスタンスを作成してオプションを追加するメソッドを作る
  def self.with_options(option)
    select = selef.new
    select.option = option
    select
  end

  def options
    @options ||= []
  end

  def add_options(arg)
    options << arg
  end
end

select = Select.with_options(1999)
select.add_options(2000)
select.add_options(2001)
select.add_options(2002)
select # => <Select:0x28707 @options=[1999, 2000, 2001, 2002]>

# next step
class Select
  def self.with_options(option)
    select = selef.new
    select.option = option
    select
  end

  def options
    @options ||= []
  end

  # チェインされる可能性があるので、selfを返すように変更する
  def add_options(arg)
    options << arg
    self
  end
end

select = Select.with_options(1999).add_options(2000).add_options(2001).add_options(2002)
select # => <Select:0x28707 @options=[1999, 2000, 2001, 2002]>

# final step
class Select
  def self.with_options(option)
    select = selef.new
    select.option = option
    select
  end

  def options
    @options ||= []
  end

  # より読みやすい流れになるようにメソッド名をリネームする
  def and(arg)
    options << arg
    self
  end
end

select = Select.with_options(1999).and(2000).and(2001).and(2002)
