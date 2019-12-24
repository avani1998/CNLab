#include<stdio.h>
void dij(int n ,int v, int cost[10][10],int dist[])
{
	int flag[10],i,j,count,w,u,min;
	for(i=1;i<=n;i++)
	{
		flag[i]=0;
		dist[i]=cost[v][i];
	}
	count=2;
	while(count<=n)
	{
		min=99;
		for(w=1;w<=n;w++)
		{
			if(dist[w]<min && !flag[w])
			{
				min=dist[w];
				u=w;
			}
		}
		flag[u]=1;
		count++;
		for(w=1;w<=n;w++)
		{
			if((dist[u]+cost[u][w]<dist[w]) && !flag[w])
			{
				dist[w]=dist[u]+cost[u][w];
			}
		}
	}
}
void main()
{
	int v,n,cost[10][10],dist[10],i,j;
	printf("Enter the number of nodes\n");
	scanf("%d",&n);
	printf("Enter the cost matrix\n");
	for(i=1;i<=n;i++)
		for(j=1;j<=n;j++)
		{
			scanf("%d",&cost[i][j]);
		}
	printf("Enter the source node\n");
	scanf("%d",&v);
	dij(n,v,cost,dist);
	printf("The shortest path\n");
	for(i=1;i<=n;i++)
		if(i!=v)
			printf("%d -> %d cost=%d\n",v,i,dist[i]);

}
