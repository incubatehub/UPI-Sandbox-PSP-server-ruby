class Response<Sequel::Model(DB[:requests])
    plugin :uuid, :field => :id
    def self.create_response(api,response)
        response=self.create(
            :api=>api,
            :response=>response
        )
        response
    end
    def get_details
        values
    end

end
