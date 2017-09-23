class App < Roda
  use Rack::Session::Cookie, :secret=>ENV['secret']

    cur_dir = File.dirname(__FILE__)

    plugin :indifferent_params
    plugin :json
    plugin :cookies
    plugin :not_found
    plugin :multi_run
    plugin :error_handler
    plugin :all_verbs
    plugin :render, :engine=>'slim', :views=>'html'
    plugin :static, ["/css", "/js", "/lib", "/images", "/fonts"]

    # include Notification

    not_found do
    # "Where did it go?"
    view 'error/404'
    end

    error do |e|
      puts
      puts "========ERROR========"
      puts e.message
      puts
      LOGGER.error(e.message)
      e.backtrace.each_with_index do |x, i|
        if (i > 50)
          break
        else
          # if (x.include?("routes"))
            if(i==0)
              LOGGER.error("#{i} - #{x}")
            end
            puts("\t\t#{x}")
          # end
        end
      end
      puts
      {
        :success => false,
        :error => e.message
      }
    end
end
class UpiApi < Roda
  use Rack::Session::Cookie, :secret=>ENV['secret']

    cur_dir = File.dirname(__FILE__)

    plugin :indifferent_params
    plugin :json
    plugin :cookies
    plugin :not_found
    plugin :error_handler
    plugin :all_verbs
    plugin :render, :engine=>'slim', :views=>'html'
    plugin :static, ["/css", "/js", "/lib", "/images", "/fonts"]

    # include Notification

    not_found do
    # "Where did it go?"
    view 'error/404'
    end

    error do |e|
      puts
      puts "========ERROR========"
      puts e.message
      puts
      LOGGER.error(e.message)
      e.backtrace.each_with_index do |x, i|
        if (i > 50)
          break
        else
          # if (x.include?("routes"))
            if(i==0)
              LOGGER.error("#{i} - #{x}")
            end
            puts("\t\t#{x}")
          # end
        end
      end
      puts
      {
        :success => false,
        :error => e.message
      }
    end
end
