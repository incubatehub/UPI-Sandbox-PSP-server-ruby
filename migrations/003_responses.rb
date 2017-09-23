class TableResponse < Sequel::Migration
  def up
    create_table :responses do
      String      :id, :primary_key=>true
      String      :transaction_id, :unique=>true
      String      :org_id, :allow_null=>true
      Text        :responses, :allow_null=>true
      String      :api
    end
  end

  def down
    drop_table :responses
  end
end
