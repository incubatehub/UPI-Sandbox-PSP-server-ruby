class Request<Sequel::Model(DB[:requests])
    plugin :uuid, :field => :id
    def self.create_request(transaction_id,api,request_body)
        resquest=self.create(
            :transaction_id=>transaction_id,
            :api=>api,
            :request=>request_body
        )
        request
    end
    def get_details
        values
    end

end
