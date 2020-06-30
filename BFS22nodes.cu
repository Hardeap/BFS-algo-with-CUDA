/*
 * BFS.cu
 *
 *  Created on: Oct 15, 2017
 *      Author: singh-h18
 */


#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include<helper_cuda.h>
#include<helper_timer.h>

#define number_of_nodes 30
#define MAX_THREADS_PER_BLOCK 512

typedef struct
{
	int f_index;
	int tnodes;
} Node;

__global__ void BFS_KERNEL(Node *d_vertices, int *d_edges, bool *d_frontier, bool *d_visited, int *d_cost,bool *update)
{

	int id = threadIdx.x + blockIdx.x * MAX_THREADS_PER_BLOCK;
	if (id > number_of_nodes)
		*update = false;


	if (d_frontier[id] == true && d_visited[id] == false)
	{
		printf("%d ", id);
		d_frontier[id] = false;
		d_visited[id] = true;
		__syncthreads();

		int f_index = d_vertices[id].f_index;
		int end = f_index + d_vertices[id].tnodes;
		for (int i = f_index; i < end; i++)
		{
			int nid = d_edges[i];

			if (d_visited[nid] == false)
			{
				d_cost[nid] = d_cost[id] + 1;
				d_frontier[nid] = true;
				*update = false;
			}

		}

	}

}




int main()
{




	 Node vertices[number_of_nodes];



	int edges[number_of_nodes];

	vertices[0].f_index = 0;
	vertices[0].tnodes = 2;

	vertices[1].f_index = 2;
	vertices[1].tnodes = 2;

	vertices[2].f_index = 4;
	vertices[2].tnodes = 2;

	vertices[3].f_index = 6;
	vertices[3].tnodes = 2;

	vertices[4].f_index = 8;
	vertices[4].tnodes = 2;


	vertices[5].f_index = 10;
	vertices[5].tnodes = 2;

	vertices[6].f_index = 12;
	vertices[6].tnodes = 2;

	vertices[7].f_index = 14;
	vertices[7].tnodes = 1;

	vertices[8].f_index = 15;
	vertices[8].tnodes = 1;

	vertices[9].f_index = 16;
	vertices[9].tnodes = 1;

	vertices[10].f_index = 17;
		vertices[10].tnodes = 1;


		vertices[11].f_index = 18;
		vertices[11].tnodes = 1;

		vertices[12].f_index = 19;
		vertices[12].tnodes = 1;

		vertices[13].f_index = 20;
		vertices[13].tnodes = 1;

		vertices[14].f_index = 21;
		vertices[14].tnodes = 1;

		vertices[15].f_index = 22;
		vertices[15].tnodes = 1;

		vertices[16].f_index = 23;
			vertices[16].tnodes = 1;


			vertices[17].f_index = 24;
			vertices[17].tnodes = 1;

			vertices[18].f_index = 25;
			vertices[18].tnodes = 1;

			vertices[19].f_index = 26;
			vertices[19].tnodes = 1;

			vertices[20].f_index = 27;
			vertices[20].tnodes = 1;

			vertices[21].f_index = 28;
			vertices[21].tnodes = 0;
	edges[0] = 1;
	edges[1] = 2;
	edges[2] = 3;
	edges[3] = 4;
	edges[4] = 5;
	edges[5] = 6;
		edges[6] = 7;
		edges[7] = 8;
		edges[8] = 9;
		edges[9] = 10;
		edges[10] = 11;
				edges[11] = 12;

				edges[12] = 13;
					edges[13] = 14;
					edges[14] = 15;
					edges[15] = 15;
					edges[16] = 16;
					edges[17] = 16;
					edges[18] = 17;
					edges[19] = 17;
					edges[20] = 18;
					edges[21] = 18;
					edges[22] = 19;
					edges[23] = 19;
					edges[24] = 20;
					edges[25] = 20;
					edges[26] = 21;
					edges[27] = 21;
			     	edges[28] = 0;


	bool h_frontier[number_of_nodes] = { false };
	bool h_visited[number_of_nodes] = { false };
	int h_cost[number_of_nodes] = { 0 };

	int source = 0;
	h_frontier[source] = true;
	int num_blocks = 1;
		int num_of_threads_per_block = number_of_nodes;


		if(num_blocks>MAX_THREADS_PER_BLOCK)
		{
			num_blocks = (int)ceil(number_of_nodes/(double)MAX_THREADS_PER_BLOCK);
			num_of_threads_per_block = MAX_THREADS_PER_BLOCK;
		}
	Node* d_vertices;
	cudaMalloc((void**)&d_vertices, sizeof(Node)*number_of_nodes);
	cudaMemcpy(d_vertices, vertices, sizeof(Node)*number_of_nodes, cudaMemcpyHostToDevice);

	int* d_edges;
	cudaMalloc((void**)&d_edges, sizeof(Node)*number_of_nodes);
	cudaMemcpy(d_edges, edges, sizeof(Node)*number_of_nodes, cudaMemcpyHostToDevice);

	bool* d_frontier;
	cudaMalloc((void**)&d_frontier, sizeof(bool)*number_of_nodes);
	cudaMemcpy(d_frontier, h_frontier, sizeof(bool)*number_of_nodes, cudaMemcpyHostToDevice);

	bool* d_visited;
	cudaMalloc((void**)&d_visited, sizeof(bool)*number_of_nodes);
	cudaMemcpy(d_visited, h_visited, sizeof(bool)*number_of_nodes, cudaMemcpyHostToDevice);

	int* d_cost;
	cudaMalloc((void**)&d_cost, sizeof(int)*number_of_nodes);
	cudaMemcpy(d_cost, h_cost, sizeof(int)*number_of_nodes, cudaMemcpyHostToDevice);




	dim3  grid( num_blocks, 1, 1);
	dim3  threads( num_of_threads_per_block, 1, 1);


	float timer1 = 0.0f;

StopWatchInterface *timer = NULL;
sdkCreateTimer(&timer);
sdkStartTimer(&timer);

	bool update;
	bool* d_update;
	cudaMalloc((void**)&d_update, sizeof(bool));
	printf("\n\n");
	int count = 0;

	printf("Order: \n");
	do {
		count++;
		update = true;
		cudaMemcpy(d_update, &update, sizeof(bool), cudaMemcpyHostToDevice);
		sdkStartTimer(&timer);
		BFS_KERNEL<<<grid, threads >>>(d_vertices, d_edges, d_frontier, d_visited, d_cost,d_update);
		cudaMemcpy(&update, d_update , sizeof(bool), cudaMemcpyDeviceToHost);
		sdkStopTimer(&timer);

		timer1 = sdkGetTimerValue(&timer);
		sdkResetTimer(&timer);
	} while (!update);
	cudaMemcpy(h_cost, d_cost, sizeof(int)*number_of_nodes, cudaMemcpyDeviceToHost);

	printf("\nTotal number of times kernel call : %d \n", count);
	printf("Total Execution time: %f (ms)", timer1);
sdkDeleteTimer(&timer);

	printf("\nCost: ");
	for (int i = 0; i<number_of_nodes; i++)
		printf( "%d    ", h_cost[i]);
	printf("\n");
 cudaFree (d_visited);
 cudaFree (d_vertices);
 cudaFree (d_edges);
 cudaFree (d_frontier);
 cudaFree (d_cost);
 cudaFree (d_update);


}
