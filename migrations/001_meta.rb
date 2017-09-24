class TableMeta < Sequel::Migration
  def up
    create_table :site_metas do
      String      :id, :primary_key=>true
      String      :org_id, :allow_null=>true
      String      :npci_sandbox_ip, :allow_null=>true
      String      :psp_unique_name, :allow_null=>true
      String      :api_key, :allow_null=>true
      Time        :created_at
      Time        :updated_at
    end
  end

  def down
    drop_table :site_metas
  end
end
