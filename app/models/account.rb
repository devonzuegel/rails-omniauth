class Account < ActiveRecord::Base
  belongs_to :user
  before_save :default_values
  
  private

    def default_values
      self.attributes = { theme: "light",
                          public_posts: false }
    end

end
