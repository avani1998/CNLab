#include<stdio.h>
int h[25]={0},l[25]={0};
int hr=0,hf=0,lr=0,lf=0;
void insert(int pri,int val)
{
	if (pri==1)
	{
		if(hr<24)
		{	
			printf("\nPacket inserted into higher priority queue\n");
			h[hr++]=val;
		}
		else 
			printf("\nQueue is full\n");
	}
	else if(pri==2)
	{
		if(lr<24)
		{
			printf("\nPacket inserted into lower priority queue\n");
			l[lr++]=val;
		}
		else 
			printf("\nQueue is full\n");
	}
	else 
		printf("\nEnter a valid priority\n");
}
void process()
{
	if(hf!=hr)
	{
		printf("\nProcessing higher priority queue\n");
		printf("%d\t",h[hf++]);
	}
	else 
	{
		if(lf!=lr)
		{
			printf("\nProcessing higher priority queue\n");
			printf("%d\t",l[lf++]);
		}
	}
	printf("\nprocess completed\n");
}


void main()
{
	int ch=1,val,pri;
	while(ch!=3)
	{
		printf("Enter your choice\n 1:insert 2:process 3:exit\n");
		scanf("%d",&ch);
		switch(ch)
		{
			case 1: printf("Enter the priority\n");
				scanf("%d",&pri);
				printf("Enter the value \n");
				scanf("%d",&val);
				insert(pri,val);
				break;
			case 2:
				process();
			case 3: break;
			default: printf("invalid option\n");
		}
	}
}	
	
