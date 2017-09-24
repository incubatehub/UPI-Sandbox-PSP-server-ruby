class Request<Sequel::Model(DB[:requests])
    plugin :uuid, :field => :id
    def self.create_request(transaction_id,api,request_body)
        req=self.create(
            :transaction_id=>transaction_id,
            :api=>api,
            :request=>request_body
        )
        req
    end
    def get_details
        values
    end

end
