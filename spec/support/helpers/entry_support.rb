module EntrySupport
  def each_entry_type(this_user, friend)
    title = Faker::Lorem.sentences(1).first
    {
      user_ent_1: create(:entry, user: this_user, title: title, public: true,  visitor: nil),
      user_ent_2: create(:entry, user: this_user, title: title, public: false, visitor: nil),
      publ_orph:  create(:entry, user: nil,       title: title, public: true,  visitor: nil),
      priv_orph:  create(:entry, user: nil,       title: title, public: false, visitor: nil),
      publ_ent:   create(:entry, user: friend,    title: title, public: true,  visitor: nil),
      priv_ent:   create(:entry, user: friend,    title: title, public: false, visitor: nil)
    }
  end

  def create_dummy_entries
    Entry.delete_all
    @friend ||= create(:user)
    @entries = each_entry_type(@user, @friend)
  end
end
