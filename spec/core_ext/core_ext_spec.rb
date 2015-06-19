describe "CoreExtension" do

  describe "Object.non_blank" do
    it "should return nil on empty and blank strings" do
      expect("".non_blank).to be_nil
      expect("    ".non_blank).to be_nil
    end

    it "should return the string as-is on non-empty strings" do 
      str = "I'm a non-empty string!"
      expect(str.non_blank).to match str
    end
  end

end
