# small Ruby script for quickly testing the services

$services = ["lighttpd", "php-cgi81", "dovecot", "postfix", "mysqld", "named"]
# returns a dict of the containers and their ID
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
    if pong_pub.split("\n").length == 1
        puts "Public DNS Status: \e[31mERROR\e[0m"
        puts "Ping output: \n #{pong_pub}"
    else
        puts "Public DNS Status: \e[32mOK\e[0m"
    end
    pong_intern = `docker exec -it #{$containers_ids['ephec-admin2_pc']} ping -c 5 intranet.woodytoys.lab`
    if pong_intern.split("\n").length == 1
        puts "Internal DNS Status: \e[31mERROR\e[0m"
        puts "Ping output: \n #{pong_intern}"
    else
        puts "Internal DNS Status: \e[32mOK\e[0m"
    end
end

def check_web
    query_pub = `curl --silent www.m2-7.ephec-ti.be`
    if query_pub.include? '<?xml version="1.0" encoding="iso-8859-1"?>' # something curl generates when giving an error page
        puts "Public Web Server Status: \e[31mERROR\e[0m"
        puts "Curl output: \n #{query_pub}"
    else
        puts "Public Web Server Status: \e[32mOK\e[0m"
    end
    query_internal = `docker exec -it #{$containers_ids['ephec-admin2_pc']} curl --silent intranet.woodytoys.lab/test.php`
    if query_pub.include? '<?xml version="1.0" encoding="iso-8859-1"?>' # something curl generates when giving an error page
        puts "Internal Web Server Status: \e[31mERROR\e[0m"
        puts "Curl output: \n #{query_internal}"
    else
        puts "Internal Web Server Status: \e[32mOK\e[0m"
    end
end

def check_ssl_cert 
    # the redirection is done so that grep actually receives the output since curl writes it in stderr instead of stdout
    # also, could you tell I love grep?
    query = `curl --verbose --silent www.m2-7.ephec-ti.be 2>&1 | grep '*  SSL certificate verify ok.'`
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