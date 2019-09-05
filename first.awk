BEGIN{
	totalSent=0;
	totalRecieved=0;
	totalLost=0;
}
{
	packetType=$5
	event=$1
	if(packetType="cbr")
	{
		if(event=="+")
		{
			totalSent++;
		}
		else if(event== "r")
		{
			totalRecieved++;
		}
		else if(event== "d")
		{
			totalLost++;
		}
	}
}
END{
	print("Total recieved: %d\n",totalRecieved);
	print("Total dropped: %d\n",totalLost);
