BEGIN{
	TCPSent =0;
	TCPRecieved =0;
	TCPlost=0;
	UDPSent=0;
	UDPRecieved=0;
	UDPLost=0;
	totalSent=0;
	totalLost=0;
	totalRecieved=0;
}
{
	packetType = $5
	event= $1
	if(packetType == "tcp")
	{
		if(event == "+")
		{
			TCPSent++;
		}
		else if(event == "r")
		{
			TCPRecieved++;
		}
		else if(event == "d")
		{
			TCPlost++;
		}
	}
	else if(packetType == "cbr")
	{
		if(event =="+")
		{
			UDPSent++;
		}
		else if(event =="r")
		{
			UDPRecieved++;
		}
		if(event =="d")
		{
			UDPLost++;
		}
	}
}
END{
	totalSent = TCPsent + UDPSent;
	totalLost= TCPLost+UDPLost;
	printf("Total TCP packets sent are %d\n", TCPSent);
	printf("Total TCP packets recieved are %d\n", TCPRecieved);
	printf("Total TCP packets dropped are %d\n", TCPLost);
	printf("Total UDP packets sent are %d\n", UDPSent);
	printf("Total UDP packets recieved are %d\n", UDPRecieved);
	printf("Total UDP packets dropped are %d\n", UDPLost);
}
