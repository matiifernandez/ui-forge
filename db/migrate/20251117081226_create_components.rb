class CreateComponents < ActiveRecord::Migration[7.1]
  def change
    create_table :components do |t|
      t.string :name
      t.text :html_code
      t.text :css_code
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
