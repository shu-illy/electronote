class AddCircuitToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :circuit, :string
  end
end
