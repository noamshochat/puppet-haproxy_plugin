alonbecker-haproxy_plugin
=========================
Mcollective plugin to manage load balancing maintnenance mode for an IIS backend server by updating status page status. 

In addition it will query haproxy stats via url and csv to determine backend server status via loadbalancer.

On each backend add following configuration:

plugin.haproxy.stats.url
