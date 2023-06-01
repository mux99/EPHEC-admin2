# small Ruby script for quickly testing the services

$services = ["lighttpd", "php-cgi81", "dovecot", "postfix", "mysqld", "named"]
# get a dict of the containers and their ID
docker_ps = `docker ps | awk '{print $1, $2}'` # awk is really cool
containers_list = docker_ps.split("\n").drop(1)
$containers_ids = {}
containers_list.each do |c|
    els = c.split ' '
    $containers_ids[els[1]] = els[0]
end

# check if all our services are currently runnning
def check_running_services
    $services.each do |s|
        running = `ps -A | grep #{s}`
        pids = `ps -A | grep #{s} | awk '{print $1}'` # I fucking love awk!!
        if running == ''
            puts "\e[31mError: service #{s} is not running\e[0m"
        else
            puts "Service #{s} running on pid #{pids.split("\n").join(', ')}"
        end
    end
end

def check_dns
    pong_pub = `ping -c 5 www.m2-7.ephec-ti.be`
    # if the output is one line long, it means that it only printed "Temporary Failure in name resolution" or smth like that
    if pong_pub.split("\n").length == 1 or pong_pub.include? "Destination host unreachable"
        puts "Public DNS Status: \e[31mERROR\e[0m"
        puts "Ping output: \n #{pong_pub}"
    else
        puts "Public DNS Status: \e[32mOK\e[0m"
    end
    pong_intern = `docker exec -it #{$containers_ids['ephec-admin2_pc']} ping -c 5 intranet.woodytoys.lab`
    if pong_intern.split("\n").length == 1 or pong_pub.include? "Destination host unreachable"
        puts "Internal DNS Status: \e[31mERROR\e[0m"
        puts "Ping output: \n #{pong_intern}"
    else
        puts "Internal DNS Status: \e[32mOK\e[0m"
    end
end

def check_web
    query_pub = `curl --silent -v www.m2-7.ephec-ti.be 2>&1 | grep ''` # this essentially just combines stdout and stderr and writes them in stdout
    if query_pub.include? '< HTTP/1.1 200 OK'
        puts "Public Web Server Status: \e[32mOK\e[0m"
    else
        puts "Public Web Server Status: \e[31mERROR\e[0m"
        puts "Curl output: \n #{query_pub}"
    end
    query_internal = `docker exec -it #{$containers_ids['ephec-admin2_pc']} curl --silent -v intranet.woodytoys.lab/test.php 2>&1 | grep ''`
    if query_pub.include? '< HTTP/1.1 200 OK'
        puts "Internal Web Server Status: \e[32mOK\e[0m"
    else
        puts "Internal Web Server Status: \e[31mERROR\e[0m"
        puts "Curl output: \n #{query_internal}"
    end
end

def check_ssl_cert
    # the redirection is done so that grep actually receives the output since curl writes the debug info stderr instead of stdout
    # also, could you tell I love grep?
    query = `curl --verbose --silent https://www.m2-7.ephec-ti.be 2>&1 | grep '*  SSL certificate verify ok.'`
    if query == ''
        puts "\e[31mERRROR: SSL certificate is invalid!\e[0m"
    else
        puts "\e[32mSSL certificate is valid\e[0m"
    end
end

puts "Checking for running services..."
check_running_services

puts "Checking the DNS services..."
puts "Running ping on public and internal services..."
check_dns

puts "Checking the web services..."
check_web
puts "Checking SSL certificate..."
check_ssl_cert