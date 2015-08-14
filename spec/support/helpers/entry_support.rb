# spec/support/helpers/entry_support.rb
module EntrySupport
  def each_entry_type(user, friend, visitor)
    {
      user_ent_1: create(:entry, user: user,   public: true,  visitor: visitor),
      user_ent_2: create(:entry, user: user,   public: false, visitor: visitor),
      publ_orph:  create(:entry, user: nil,    public: true,  visitor: nil),
      priv_orph:  create(:entry, user: nil,    public: false, visitor: nil),
      publ_ent:   create(:entry, user: friend, public: true,  visitor: nil),
      priv_ent:   create(:entry, user: friend, public: false, visitor: nil)
    }
  end

  def create_dummy_entries
    Entry.delete_all
    @user ||= create(:user)
    @visitor ||= create(:visitor, user: @user)
    @friend ||= create(:user)
    @entries = each_entry_type(@user, @friend, @visitor)
  end
end
