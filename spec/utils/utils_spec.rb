describe "Utils" do

  describe "non_blank" do
    it "should return nil on empty and blank strings" do
      expect(non_blank "").to be_nil
      expect(non_blank "    ").to be_nil
    end

    it "should return nil on nil" do
      expect(non_blank nil).to be_nil
    end

    it "should return the string as-is on non-empty strings" do 
      str = "I'm a non-empty string!"
      expect(non_blank str).to match str
    end

    it "should return nil on any non-string" do 
      expect(non_blank []).to be_nil
      expect(non_blank({ param: 1 })).to be_nil
      expect(non_blank FactoryGirl.build(:entry)).to be_nil
    end
  end

end
