# spec/support/helpers/entry_support.rb
module EntrySupport
  # Create one of each of the 6 possible entry types from permutations of
  # private/public and visitor/friend/orphan.
  def each_entry_type(user, friend, visitor, opts = {})
    opts.delete_if { |_key, val| val.blank? }
    {
      user_ent_1: create(:entry, opts.merge(user: user,   public: true,  visitor: visitor)),
      user_ent_2: create(:entry, opts.merge(user: user,   public: false, visitor: visitor)),
      publ_orph:  create(:entry, opts.merge(user: nil,    public: true,  visitor: nil)),
      priv_orph:  create(:entry, opts.merge(user: nil,    public: false, visitor: nil)),
      publ_ent:   create(:entry, opts.merge(user: friend, public: true,  visitor: nil)),
      priv_ent:   create(:entry, opts.merge(user: friend, public: false, visitor: nil))
    }
  end

  def create_dummy_entries(clear: true, title: nil)
    Entry.delete_all if clear  # Clear all existing entries by default.
    @user ||= create(:user)
    @visitor ||= create(:visitor, user: @user)
    @friend ||= create(:user)
    @entries = each_entry_type(@user, @friend, @visitor, title: title)
  end
end
