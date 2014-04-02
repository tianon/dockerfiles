# see https://raw.github.com/defunkt/unicorn/master/examples/unicorn.conf.rb

working_directory '/apps/rails'

listen '/apps/unicorn/unicorn.sock', :backlog => 64
pid '/apps/unicorn/unicorn.pid'

worker_processes 4
timeout 30

# this is safe since nginx is on the same machine as unicorn ;)
check_client_connection false
