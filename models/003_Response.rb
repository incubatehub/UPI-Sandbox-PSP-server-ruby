class Response<Sequel::Model(DB[:responses])
    plugin :uuid, :field => :id
    def self.create_response(api,response)
        rsp=self.create(
            :api=>api,
            :response=>response
        )
        rsp
    end
    def get_details
        values
    end

end
