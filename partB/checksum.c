#include<stdio.h>
#include<string.h>
int checksum(int f1)
{
	char in[100];
	int temp,sum=0,i,n;
	scanf("%s",in);
	if (strlen(in)%2!=0)
		n=(strlen(in)+1)/2;
	else
		n=(strlen(in))/2;
	for(i=0;i<n;i++)
	{
		temp=in[i*2];
		temp=(temp*256)+in[(i*2)+1];
		sum=sum+temp;
	}
	if (f1==1)
	{
		printf("Enter the checksum value\n");
		scanf("%x",&temp);
		sum+=temp;
	}
	if(sum%65536!=0)
	{
		n=sum%65536;
		sum=(sum/65536) +n;
	}
	sum=65535-sum;
	printf("%x\n",sum);
	return(sum);
}
	
void main()
{
	int ch,sum;
	do{
		printf("choose one option\n 1:Encode 2:Decode 3:Exit \n");
		scanf("%d",&ch);
		switch(ch)
		{
			case 1: printf("Enter the string\n");
				sum=checksum(0);
				printf("The checksum is %x \n",sum);
				break;
			case 2: printf("Enter the string\n");
				sum=checksum(1);
				if(sum==0)
					printf("The data is correct\n");
				else 
					printf("The data has been corrupted\n");
				break;
			case 3:
				break;
		}
	} while(ch!=3);
}

