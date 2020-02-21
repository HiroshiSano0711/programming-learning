# before
def self.find(selector, conditions="", *joins)
  sql = ["SELECT * from books"]
  joins.each do |join_table|
    sql << "LEFT OUTER JOIN #{join_table} ON"
    sql << "books.#{join_table.to_s.chap}_id"
    sql << " = #{join_table}.id"
  end
  sql << "WHERE #{conditions}" unless conditions.empty?
  sql << "LIMIT 1" if selector == :first
  connection.find(sql.join(" "))
end

# after
def self.find(selector, hash={})
  hash[:joins] ||= []
  hash[:conditions] ||= ""
  sql = ["SELECT * from books"]
  hash[:joins].each do |join_table|
    sql << "LEFT OUTER JOIN #{join_table} ON"
    sql << "books.#{join_table.to_s.chap}_id"
    sql << " = #{join_table}.id"
  end
  sql << "WHERE #{hash[:conditions]}" unless hash[:conditions].empty?
  sql << "LIMIT 1" if selector == :first
  connection.find(sql.join(" "))
end

# finally
module AssertValidKeys
  def aseert_valid_keys(*valid_keys)
    unknown_keys = key - [valid_keys].flatten
    if unknown_keys.any?
      raise(ArgumentError, "Unknown Key(s): #{unknown_keys.join(', ')}")
    end
  end
end

Hash.send :include, AssertValidKeys

def self.find(selector, hash={})
  hash.aseert_valid_keys :joins, :conditions

  hash[:joins] ||= []
  hash[:conditions] ||= ""

  sql = ["SELECT * from books"]
  hash[:joins].each do |join_table|
    sql << "LEFT OUTER JOIN #{join_table} ON"
    sql << "books.#{join_table.to_s.chap}_id"
    sql << " = #{join_table}.id"
  end

  sql << "WHERE #{hash[:conditions]}" unless hash[:conditions].empty?
  sql << "LIMIT 1" if selector == :first

  connection.find(sql.join(" "))
end
