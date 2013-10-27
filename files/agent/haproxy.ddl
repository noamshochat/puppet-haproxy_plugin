metadata :name        => "haproxy",
         :description => "Performs haproxy actions on status page of backend server",
         :author      => "Alon Becker",
         :license     => "MIT",
         :version     => "1.0",
         :url         => "http://etoro.com",
         :timeout     => 120

['enable','disable'].each do |act|
  action act, :description => "#{act.capitalize} backend server in HAProxy" do
    output :status,
           :description => "Return status of updating backend server status page.",
           :display_as  => "Return Status"
  end
end