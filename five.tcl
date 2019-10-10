#5 Simulate an ethernet LAN using n nodes and set multiple traffic nodes and determine collision different nodes

set ns [new Simulator]

set traceFile [open 5.tr w]
$ns trace-all $traceFile
set namFile [open 5.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns traceFile namFile
	$ns flush-trace
	close $traceFile
	close $namFile
	exec awk -f five.awk 5.tr &
	exec nam 5.nam &
	exit 0
}

#create 7 noses
for {set i 0} {$i < 7} {incr i} {
	set n($i) [$ns node]
}

#set colors
$ns color 1 res
$ns color 2 blue


$n(1) color red
$n(1) shape box
$n(5) color red
$n(5) shape box
$n(0) color blue
$n(4) color blue

#create links between the nodes
$ns duplex-link $n(0) $n(2) 1Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 1Mb 10ms DropTail
$ns simplex-link $n(2) $n(3) 0.3Mb 100ms DropTail
$ns simplex-link $n(3) $n(2) 0.3Mb 100ms DropTail

#create LAN setup
set lan [$ns newLan "$n(3) $n(4) $n(5) $n(6)" 0.5Mb 40ms LL
Queue/DropTail MAC/Csma/Cd Channel]

#position the nides for NAM
$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns simplex-link-op $n(2) $n(3) orient right
$ns simplex-link-op $n(3) $n(2) orient left

#create A tcp agent
set TCPAgent [new Agent/TCP/Newreno]
$ns attach-agent $n(0) $TCPAgent
$TCPAgent set fid_ 1
$TCPAgent set packetSize_ 552

#create a tcp sink
set TCPSink [new Agent/TCPSink/DelAck]
$ns attach-agent $n(4) $TCPSink
$ns connect $TCPAgent $TCPSink

#attach ftp
set ftp [new Application/FTP]
$ftp attach-agent $TCPAgent

#create udp agent 
set UDPAgent [new Agent/UDP]
$ns attach-agent $n(1) $UDPAgent
$UDPAgent set fid_ 2
set nullSink [new Agent/Null]
$ns attach-agent $n(6) $nullSink
$ns connect $UDPAgent $nullSink

#attach a cbr applicatiobn to the udp agent 
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $UDPAgent 
$cbr set type_ CBR
$cbr set packetSize 1000
$cbr set rate 0.05Mb
$cbr set random_ false

$ns at 0.0 "$n(0) label TCP_Traffic"
$ns at 0.0 "$n(1) label UDP_Traffic"
$ns at 0.3 "$cbr start"
$ns at 0.8 "$ftp start"
$ns at 7.0 "$ftp stop"
$ns at 7.5 "$cbr stop"
$ns at 8.0 "finish"
$ns run
