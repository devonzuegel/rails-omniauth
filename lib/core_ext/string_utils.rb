class String
  def non_blank
    self unless self.blank?
  end
end