#2 simulate the differeetn types of internet traffic sucjh as ftp amd telnet over network and analyze the throughput


#create a simulator object 
set ns  [new Simulator]

#set up trace file
set tracefile [open 2.tr w]
$ns trace-all 4traceFile
set namFile [open 2.nam w]








#create 4 nodes
for {set i 0} {$i<4} {incr i}{
	set n($i) [$ns node]
}

#create links between the nodes
$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(2) $n(3) 900kb 10ms DropTail
$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail


#set queue size
$ns queue-limit $n(0) $n(2) 10


#set tcp telnet
set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink
$ns connect $tcp0 $sink0

#attach telnet applicatiobn over tcp
set telent [new Application/Telnet]
$telnet attach-agent $tcp0
$telnet aet interval 0

#ftp set type _FTP

#set tcp ftp connection between n(1) and n(3)
set tcp1 [new Agent/TCP]
$ns atach-agent $n(1) $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink1
$ns connect $tcp1 $sink1

#attach telnet application over tcp 
set ftp [new Application/FTP]
$ftp attach-agent $tcp1
$ftp set type_ FTP

# Schedule events
$ns at 0.5 "$telnet start"
$ns at 0.6 "$ftp start"
$ns at 24.5 "$telnet stop"
$ns at 24.5 "$ftp stop"
$ns at 25.0 "finish"

#run simulation 
$ns run

