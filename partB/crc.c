#include<string.h>
#include<stdio.h>
#define N strlen(g)

char t[28],cs[28],g[]="10001000000100001";
int a,e,c;

void xor()
{
	for(c=1;c<N;c++)
		cs[c]=((cs[c]==g[c])?'0':'1');
}

void crc()
{
	for(e=0;e<N;e++)
		cs[e]=t[e];
	do{
		if(cs[0]=='1')
			xor();
		for (c=0;c<N-1;c++)
			cs[c]=cs[c+1];
		cs[c]=t[e++];
	}while(e<=a+N-1);
}

void main()
{
	printf("Enter the data\n");
	scanf("%s",t);
	printf("Generating codeword %s\n",g);
	a=strlen(t);
	for(e=a;e<a+N-1;e++)
		t[e]='0';
	printf("The modified data is %s\n",t);
	crc();
	printf("The checksum is %s\n",cs);
	for(e=a;e<a+N-1;e++)
		t[e]=cs[e-a];
	printf("The codeword is %s\n",t);
	printf("Test for error? yes(0) no(1)");
	scanf("%d",&e);
	if(e==0)
	{
		do{
			printf("Enter position to insert error\n");
			scanf("%d",&e);
		}while(e==0 || e>a+N-1);
		
		t[e-1]=(t[e-1]=='0')?'1':'0';
		printf("Errornous data is %s\n",t);
	}
	else
	{
		exit(0);
	}
	crc();
	for(e=0;(e<N-1) && (cs[e]!='1');e++)
	{
		if(e<N-1)
		{
			printf("Error detected\n");
		}
		else 
		{
			printf("NO Error detected");
		}
	}
}
