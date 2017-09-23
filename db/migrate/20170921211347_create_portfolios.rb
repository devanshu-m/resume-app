class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.text :summary
      t.text :exp
      t.text :selected_publications
      t.text :education
      t.text :sample_work
      t.text :projects
      t.text :hobbies
      t.text :locations
      t.text :dates
      t.text :core
      t.text :comapny
      t.text :position
      t.text :skills

      t.timestamps null: false
    end
  end
end
