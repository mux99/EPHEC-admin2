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
        puts "\e[31mError in public DNS service\e[0m"
    else
        puts "Public DNS service is working"
    end
    pong_intern = `docker exec -it #{containers_ids['ephec-admin2_pc']} 'ping -c 5 intranet.woodytoys.lab'`
    if pong_intern.split("\n").length == 1
        puts "\e[31mError in internal DNS service\e[0m"
    else
        puts "Internal DNS service is working"
    end
end

def check_web
    query_pub = `curl www.m2-7.ephec-ti.be`
    if query_pub.include? '<?xml version="1.0" encoding="iso-8859-1"?>' # something curl generates when giving an error page
        puts "\e[31mError: the web server is not runnning or the document was not found\e[0m"
    else
        puts "Public Web server is working"
    end
    query_internal = `docker exec -it #{containers_ids['ephec-admin2_pc']} 'curl intranet.woodytoys.lab/test.php'`
    if query_pub.include? '<?xml version="1.0" encoding="iso-8859-1"?>' # something curl generates when giving an error page
        puts "\e[31mError: the web server is not runnning or the document was not found or the PHP document contains errors\e[0m"
    else
        puts "Internal Web server is working"
    end
end

puts "Checking for running services"
check_running_services

puts "Checking the DNS services"
check_dns

puts "Checking the web services"
check_web