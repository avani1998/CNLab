BEGIN {
	TCPPacketRec =0;
	UDPPacketRec=0;
	TCPPacketDrop=0;
	UCPPacketDrop=0;
}
{
	event =$1;
	packetType =$5;
	if(event =="r"){
		if(packetType == "tcp"){
			TCPPacketRec++;
		}
		else if(packetType =="cbr"){
			UDPPacketRec++;
		}
	}
	else if (event == "d"){
		if(packetType == "tcp"){
			TCPPacketDrop++;
		}
		else if(packetType =="cbr"){
			UDPPacketDrop++;
		}
	}
}
END{
	printf("\n TCP:\t Recieved: %d\t Dropped: %d", TCPPacketRec,TCPPacketDrop);
	printf("\n UDP:\t Recieved: %d\t Dropped: %d", UDPPacketRec,UDPPacketDrop);
}
