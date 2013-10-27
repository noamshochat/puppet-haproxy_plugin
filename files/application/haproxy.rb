class MCollective::Application::Haproxy<MCollective::Application
  description "Reports on usage for a specific fact"


  def main
    mc = rpcclient("haproxy")

    printrpc mc.haproxy(:options => options)

    printrpcstats
  end
end
