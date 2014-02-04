require 'mcollective'
require 'csv'
require 'net/http'
require 'uri'

module MCollective
  module Agent
    class Haproxy < RPC::Agent

      ['enable','maintenance'].each do |act|
        action act do
          change_status act
        end
      end

      action 'status' do
        haproxy_stats_url = config.pluginconf['haproxy.stats.url'] || ''
        if haproxy_stats_url == '' then
          reply[:status]=1
          reply[:stderr]='Haproxy stats url is not configured in server.cfg'
          exit 1
        end
        check_status(config.identity, haproxy_stats_url)
      end

      private
      def change_status(action)
        message = ''
        status_file = 'C:\inetpub\wwwroot\MonitorSite\status.html'
        case action
          when 'enable'
            message = "OK"
          when 'maintenance'
            message = "MAINTENANCE"
        end
        begin
          Log.info ("Beginning #{action} backend server in HAProxy")
          reply[:status] = File.open(status_file, 'w') { |file| file.write(message) }
          Log.info ("Finished #{action} backend server in HAProxy")
        end
      end

      def check_status(server_name,haproxy_stats_url)
        stats = open(haproxy_stats_url)
        message = 'DOWN'
        CSV.parse(stats) do |row|
          if row[0] !~ /-maint$/ && row[1] == server_name then
            message = row[17]
          end
          reply[:msg] = message
        end
      end

      def open(url)
        Net::HTTP.get(URI.parse(url))
      end
    end
  end
end
