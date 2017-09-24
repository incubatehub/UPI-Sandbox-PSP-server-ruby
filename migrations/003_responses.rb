class TableResponse < Sequel::Migration
  def up
    create_table :responses do
      String      :id, :primary_key=>true
      String      :transaction_id
      String      :org_id, :allow_null=>true
      Text        :response, :allow_null=>true
      String      :api
      Time        :created_at
      Time        :updated_at
    end
  end

  def down
    drop_table :responses
  end
end
