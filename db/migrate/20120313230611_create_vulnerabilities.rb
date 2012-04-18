class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end
end
