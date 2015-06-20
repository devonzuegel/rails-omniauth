describe Utils do

  describe ".non_blank" do
    it "should return nil on empty and blank strings" do
      expect(Utils.non_blank "").to be_nil
      expect(Utils.non_blank "    ").to be_nil
    end

    it "should return nil on nil" do
      expect(Utils.non_blank nil).to be_nil
    end

    it "should return the string as-is on non-empty strings" do 
      str = "I'm a non-empty string!"
      expect(Utils.non_blank str).to match str
    end

    it "should have expected behavior on any non-string that is blank" do 
      expect(Utils.non_blank []).to be_nil
      expect(Utils.non_blank {}).to be_nil
    end

    it "should have expected behavior on any non-string that is not blank" do 
      entry = FactoryGirl.build(:entry)
      expect(Utils.non_blank entry).to match entry
      expect(Utils.non_blank({ param: 1 })).to match({ param: 1 })
      expect(Utils.non_blank ({:"" => ""})).to match({:"" => ""})

    end
  end

  describe ".blank_params_to_nil" do 
    it "should make all blank params nil in basic hash" do
      input = { 
        param1: "   ", 
        param2: "",
        param3: nil,
        param4: "non-blank",
        param5: [],
        param6: {},
      }
      expected_output = { 
        param1: nil, 
        param2: nil,
        param3: nil,
        param4: "non-blank" ,
        param5: nil,
        param6: nil,
      }
      expect(Utils.blank_params_to_nil input).to match expected_output
    end

    it "should make all blank params nil in multi-level hash" do 
      input = { 
        level1: {
          param1: "   ", 
          param2: "",
          param3: nil,
          param4: "non-blank",
          param5: {},
          param6: [],
        } 
      }
      expected_output = { 
        level1: { 
          param1: nil, 
          param2: nil,
          param3: nil,
          param4: "non-blank",
          param5: nil,
          param6: nil,
        }  
      }
      expect(Utils.blank_params_to_nil input).to match expected_output
    end

    it "should return basic hash without change if no blanks" do
      input = { 
        param1: "xx", 
        param2: [1, 2, 3]
      }
      expect(Utils.blank_params_to_nil input).to match input
    end

    it "should return multi-level hash without change if no blanks" do 
      input = { 
        level1: {
          param1: "non-blank", 
          param2: [1, 2, 3]
          } 
        }
      expect(Utils.blank_params_to_nil input).to match input
    end
  end
end
