def non_blank str=nil
  str unless str.blank? || !str.is_a?(String)
end