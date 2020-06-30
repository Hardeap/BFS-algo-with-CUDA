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

#define number_of_nodes 90
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
	vertices[3].tnodes = 3;

	vertices[4].f_index = 9;
	vertices[4].tnodes = 2;


	vertices[5].f_index = 11;
	vertices[5].tnodes = 2;

	vertices[6].f_index = 13;
	vertices[6].tnodes = 3;

	vertices[7].f_index = 16;
	vertices[7].tnodes = 3;

	vertices[8].f_index = 19;
	vertices[8].tnodes = 2;

	vertices[9].f_index = 21;
	vertices[9].tnodes = 2;

	vertices[10].f_index = 23;
		vertices[10].tnodes = 1;


		vertices[11].f_index = 24;
		vertices[11].tnodes = 1;

		vertices[12].f_index = 25;
		vertices[12].tnodes = 1;

		vertices[13].f_index = 26;
		vertices[13].tnodes = 1;

		vertices[14].f_index = 27;
		vertices[14].tnodes = 2;

		vertices[15].f_index = 29;
		vertices[15].tnodes = 2;

		vertices[16].f_index = 31;
			vertices[16].tnodes = 3;


			vertices[17].f_index = 34;
			vertices[17].tnodes = 1;

			vertices[18].f_index = 35;
			vertices[18].tnodes = 1;

			vertices[19].f_index = 36;
			vertices[19].tnodes = 1;

			vertices[20].f_index = 37;
			vertices[20].tnodes = 1;

			vertices[21].f_index = 38;
			vertices[21].tnodes = 1;
			vertices[22].f_index = 39;
					vertices[22].tnodes = 1;


					vertices[23].f_index = 40;
					vertices[23].tnodes = 1;

					vertices[24].f_index = 41;
					vertices[24].tnodes = 1;

					vertices[25].f_index = 42;
					vertices[25].tnodes = 1;

					vertices[26].f_index = 43;
					vertices[26].tnodes = 1;

					vertices[27].f_index = 44;
					vertices[27].tnodes = 1;

					vertices[28].f_index = 45;
						vertices[28].tnodes = 1;

						vertices[29].f_index = 46;
						vertices[29].tnodes = 1;

						vertices[30].f_index = 47;
						vertices[30].tnodes = 1;

						vertices[31].f_index = 48;
						vertices[31].tnodes = 1;

						vertices[32].f_index = 49;
						vertices[32].tnodes = 1;
						vertices[33].f_index = 50;
								vertices[33].tnodes = 1;


								vertices[34].f_index = 51;
								vertices[34].tnodes = 1;

								vertices[35].f_index = 52;
								vertices[35].tnodes = 1;

								vertices[36].f_index = 53;
								vertices[36].tnodes = 1;

								vertices[37].f_index = 54;
								vertices[37].tnodes = 1;

								vertices[38].f_index = 55;
								vertices[38].tnodes = 1;

								vertices[39].f_index = 56;
									vertices[39].tnodes = 1;


									vertices[40].f_index = 57;
									vertices[40].tnodes = 1;

									vertices[41].f_index = 58;
									vertices[41].tnodes = 1;

									vertices[42].f_index = 59;
									vertices[42].tnodes = 1;

									vertices[43].f_index = 60;
									vertices[43].tnodes = 1;

									vertices[44].f_index = 61;
									vertices[44].tnodes = 1;
									vertices[45].f_index = 62;
											vertices[45].tnodes = 1;


											vertices[46].f_index = 63;
											vertices[46].tnodes = 1;

											vertices[47].f_index = 64;
											vertices[47].tnodes = 1;

											vertices[48].f_index = 65;
											vertices[48].tnodes = 1;

											vertices[49].f_index = 66;
											vertices[49].tnodes = 1;

											vertices[50].f_index = 67;
											vertices[50].tnodes = 1;

											vertices[51].f_index = 68;
												vertices[51].tnodes = 1;


												vertices[52].f_index = 69;
												vertices[52].tnodes = 1;

												vertices[53].f_index = 70;
												vertices[53].tnodes = 1;

												vertices[54].f_index = 71;
												vertices[54].tnodes = 2;

												vertices[55].f_index = 73;
												vertices[55].tnodes = 2;

												vertices[56].f_index = 75;
												vertices[56].tnodes = 1;
												vertices[57].f_index = 76;
														vertices[57].tnodes = 1;


														vertices[58].f_index = 77;
														vertices[58].tnodes = 1;

														vertices[59].f_index = 78;
														vertices[59].tnodes = 1;

														vertices[60].f_index = 79;
														vertices[60].tnodes = 1;

														vertices[61].f_index = 80;
														vertices[61].tnodes = 1;

														vertices[62].f_index = 81;
														vertices[62].tnodes = 1;

														vertices[63].f_index = 82;
															vertices[63].tnodes = 0;



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
					edges[15] = 16;
					edges[16] = 17;
					edges[17] = 18;
					edges[18] = 19;
					edges[19] = 20;
					edges[20] = 21;
					edges[21] = 22;
					edges[22] = 23;
					edges[23] = 24;
					edges[24] = 24;
					edges[25] = 25;
					edges[26] = 25;
					edges[27] = 26;
			     	edges[28] = 27;
			     	edges[29] = 28;
			     						edges[30] = 29;
			     						edges[31] = 30;
			     						edges[32] = 31;
			     						edges[33] = 32;
			     						edges[34] = 33;
			     						edges[35] = 34;
			     						edges[36] = 35;
			     						edges[37] = 36;
			     						edges[38] = 36;
			     						edges[39] = 37;
			     						edges[40] = 37;
			     						edges[41] = 38;
			     						edges[42] = 38;
			     						edges[43] = 39;
			     				     	edges[44] = 40;
			     				   	edges[45] = 41;
			     				   					edges[46] = 42;
			     				   					edges[47] = 43;
			     				   					edges[48] = 43;
			     				   					edges[49] = 44;
			     				   					edges[50] = 45;
			     				   					edges[51] = 45;
			     				   					edges[52] = 46;
			     				   					edges[53] = 46;
			     				   					edges[54] = 47;
			     				   					edges[55] = 47;
			     				   					edges[56] = 48;
			     				   					edges[57] = 48;
			     				   					edges[58] = 49;
			     				   					edges[59] = 49;
			     				   			     	edges[60] = 50;
			     				   			     	edges[61] = 50;

			     				   				edges[62] = 51;
			     				   								edges[63] = 51;
			     				   								edges[64] = 52;
			     				   								edges[65] = 52;
			     				   								edges[66] = 53;
			     				   								edges[67] = 53;
			     				   								edges[68] = 54;
			     				   								edges[69] = 55;
			     				   								edges[70] = 55;
			     				   								edges[71] = 56;
			     				   								edges[72] = 57;
			     				   								edges[73] = 58;
			     				   								edges[74] = 59;
			     				   								edges[75] = 60;
			     				   								edges[76] = 60;
			     				   						     	edges[77] = 61;
			     				   						     	edges[78] = 61;
			     				   						    edges[79] = 62;
			     				   						    	edges[80] = 62;
			      				   								edges[81] = 63;
			     				   						        edges[82] = 0;

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
