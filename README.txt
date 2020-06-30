1. Create new CUDA-C project in Nsight eclipse.
2. Copy folder lib anywhere in the system. (floder lib have header file helper_cuda.h and timer_cuda.h)
3. open project properties than open C/C++ General and than open paths and symbols.
4. Click on CUDA C in languages and add path to the folder  " lib " in incude directories.
 (this we are doing to remove error " unresolved inclusion " for header files )

5. For experiment number 1.
- Import file BFS10nodes.cu and build and run it.

6. For experiment number 2.
- Import file BFS22nodes.cu and build and run it.

7. For experiment number 3.
- Import file BFS64nodes.cu and build and run it.

Experiment 4 is done by using graph data presented in the fig 1. in report 
