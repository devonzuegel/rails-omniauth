# lib/core_ext/hash.rb
# ---
# Extends core Hash class.
class Hash
  # Include specified attributes in resulting filtered hash, or if no attributes are
  # specified, include **all** attributes.
  def filtered_vals(*attributes)
    filtered = attributes.blank? ? self : slice(*attributes)
    filtered.map { |_key, val| val }
  end
end
