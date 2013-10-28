require 'mcollective'

module MCollective
  module Agent
    class Haproxy < RPC::Agent

      metadata  :name        => "haproxy",
                :description => "Enable or put  backend servers into maintenance mode with changing content on status page of backend server",
                :author      => "Alon Becker",
                :license     => "MIT",
                :version     => "0.1",
                :url         => "http://etoro.com",
                :timeout     => 60

      ['enable','maintenance'].each do |act|
        action act do
          change_status act, request
        end
      end

      private
      def change_status(action)
        message = ''
        status_file = 'C:\inetpub\wwwroot\Monitor\status.html'
        case action
          when 'enable'
            message = "OK"
          when 'disable'
            message = "MAINTENANCE"
        end
        begin
          Log.info ("Beginning #{action} backend server in HAProxy")
          reply[:status] = File.open(status_file, 'w') { |file| file.write(message) }
          Log.info ("Finished #{action} backend server in HAProxy")
        end
      end

    end
  end
end