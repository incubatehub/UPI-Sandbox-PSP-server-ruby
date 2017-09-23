class App < Roda

    route do |r|

      @errors=session["errors"]
      session.delete("errors")
      puts "Hitting route"
        r.on "Config" do
          r.get do
            @current="Config"
            view  "meta_config"
          end
          r.post do
              puts "!params[:org_id] || params[:org_id].strip.length<1"
              puts !params[:org_id] || params[:org_id].strip.length<1
              if(!params[:org_id] || params[:org_id].strip.length<1)
                session["errors"]="Organization Id Cannot be empty"
                r.redirect "/Config"
              elsif(!params[:npci_sandbox_ip] || params[:npci_sandbox_ip].strip.length<1)
                session["errors"]="UPI Sandbox Ip Cannot be empty"
                r.redirect "/Config"
              elsif(!params[:psp_unique_name] || params[:psp_unique_name].strip.length<1)
                session["errors"]="PSP Unique name Cannot be empty"
                r.redirect "/Config"
              elsif(!params[:api_key] || params[:api_key].strip.length<1)
                session["errors"]="Api Key Cannot be empty"
                r.redirect "/Config"
              end
              # response.headers["Cache-Control"] = "no-cache, no-store"
              # response.headers["Pragma"] = "no-cache"
              # response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
              ret=Meta.config_meta(params)
              r.redirect "/"
          end
        end
        r.get "Pay" do
          r.redirect "/Config" if(Meta.count<1)
          @current="Pay"
          @dummydata=File.read("./templates/Pay/ReqPay.xml")
          view  "request_page/configure"
        end
        r.get "AuthDetails" do
          r.redirect "/Config" if(Meta.count<1)
          @current="AuthDetails"
          @dummydata=File.read("./templates/AuthDetails/RespAuthDetails.xml")
          view  "request_page/configure"
        end
        r.get "RegMob" do
          r.redirect "/Config" if(Meta.count<1)
          @current="RegMob"
          @dummydata=File.read("./templates/RegMob/ReqRegMob.xml")
          view  "request_page/configure"
        end
        r.get "ChkTxn" do
          r.redirect "/Config" if(Meta.count<1)
          @current="ChkTxn"
          @dummydata=File.read("./templates/ChkTxn/ReqChkTxn.xml")
          view  "request_page/configure"
        end
        r.get "SetCre" do
          r.redirect "/Config" if(Meta.count<1)
          @current="SetCre"
          @dummydata=File.read("./templates/SetCre/ReqSetCre.xml")
          view  "request_page/configure"
        end
        r.get "BalEnq" do
          r.redirect "/Config" if(Meta.count<1)
          @current="BalEnq"
          @dummydata=File.read("./templates/BalEnq/ReqBalEnq.xml")
          view  "request_page/configure"
        end
        r.get "ListAccount" do
          r.redirect "/Config" if(Meta.count<1)
          @current="ListAccount"
          @dummydata=File.read("./templates/ListAccount/ReqListAccount.xml")
          view  "request_page/configure"
        end
        r.get "ListAccPvd" do
          r.redirect "/Config" if(Meta.count<1)
          @current="ListAccPvd"
          @dummydata=File.read("./templates/ListAccPvd/ReqListAccPvd.xml")
          view  "request_page/configure"
        end
        r.post "request" do
              data=JSON.parse(request.body.read) rescue {}
              meta=Meta.first
              if(meta)
                  response = Unirest.post "http://#{meta.npci_sandbox_ip}/#{meta.psp_unique_name}:#{meta.api_key}/upi/#{data['api']}/urn:txnid:#{data['transaction_id']}",
                            headers:{ "Content-Type" => "application/xml" },
                            parameters:data["xml"]

                  response.code
                  response.headers
                  response_body=response.body
                  response.raw_body
              end
              {:success=>true,:data=>response_body}
        end
        r.on "upi" do
            puts "Hitting UPI"
              r.on "ReqPay" do
                  r.post do
                    body=request.body.read
                    puts body
                    {:success=>true}
                  end
                  r.get do
                      r.redirect "/documentation/ReqPay"
                  end #end REQ PAY GET
              end #end REQ PAY

              r.on "RespPay" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespPay',{:message=>body.to_s})
                  {:success=>true}
                end#end RESP PAY POST
                r.get do

                end #end RESP PAY GET
              end #end RESP PAY

              r.on "ReqAuthDetails" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/ReqAuthDetails',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end REQ AUTH DETAILS

              r.on "RespAuthDetails" do
                  r.post do
                    body=request.body.read
                    puts body
                    {:success=>true}
                  end
              end #end RESP AUTH DETAILS

              r.on "ReqBalEnq" do
                r.post do
                  body=request.body.read
                  puts body
                  {:success=>true}
                end
              end #end REQ BAL ENQ

              r.on "RespBalEnq" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespBalEnq',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP BAL ENQ

              r.on "ReqChkTxn" do
                r.post do
                  body=request.body.read
                  puts body
                  {:success=>true}
                end
              end #end REQ CHK TXN

              r.on "RespChkTxn" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespChkTxn',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP CHK TXN

              r.on "ReqListAccount" do
                r.post do
                  body=request.body.read
                  puts body
                  {:success=>true}
                end
              end #end REQ LIST ACCOUNT

              r.on "RespListAccount" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespListAccount',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP LIST ACCOUNT

              r.on "ReqListAccPvd" do
                r.post do
                  body=request.body.read
                  puts body
                  {:success=>true}
                end
              end #end REQ LIST ACCOUNT PROVIDER

              r.on "RespListAccPvd" do
                  puts "Hitting in Resp ListAccPvd"
                  r.post do
                    body=request.body.read
                    puts body.to_s
                    $communication.get_client.publish('/RespListAccPvd',{:message=>body.to_s})
                    {:success=>true}
                  end
              end #end RESP LIST ACCOUNT PROVIDER

              r.on "ReqListPsp" do
                r.post do
                  body=request.body.read
                  puts body
                  {:success=>true}
                end
              end #end REQ LIST PSP

              r.on "RespListPsp" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespListPsp',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP LIST PSP

              r.on "ReqRegMob" do
                  r.post do
                    body=request.body.read
                    puts body
                    {:success=>true}
                  end
              end #end REQ REG MOB

              r.on "RespRegMob" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespRegMob',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP REG MOB

              r.on "ReqSetCre" do
                  r.post do
                    body=request.body.read
                    puts body
                    {:success=>true}
                  end
              end #end REQ SET CRE

              r.on "RespSetCre" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespSetCre',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP SET CRE

              r.on "ReqValAdd" do
                  r.post do
                    body=request.body.read
                    puts body
                    {:success=>true}
                  end
              end #end REQ VAL ADD

              r.on "RespValAdd" do
                r.post do
                  body=request.body.read
                  puts body
                  $communication.get_client.publish('/RespValAdd',{:message=>body.to_s})
                  {:success=>true}
                end
              end #end RESP VAL ADD

        end
        r.get do
           view "index"
        end
        r.post "initiate-request" do

        end
    end
end
