class HBase
  #
  #
  #
  #
  #
class Scoped
  include Enumerable
  include Scoped::Aggregation
  include HBase::Util

  attr_reader :table

  # blah blah
  # blah blah
  def unscope
    Scoped.send(:new, @table)
  end

  print('dfdf')
