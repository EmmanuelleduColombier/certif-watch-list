class AddreferenceToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference :reviews, :list, foreign_key: true
  end
end
