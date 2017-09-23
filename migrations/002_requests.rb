class TableRequest < Sequel::Migration
  def up
    create_table :requests do
      String      :id, :primary_key=>true
      String      :transaction_id, :unique=>true
      String      :org_id, :allow_null=>true
      Text        :request, :allow_null=>true
      String      :api
    end
  end

  def down
    drop_table :requests
  end
end
