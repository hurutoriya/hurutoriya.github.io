---
title: "How to install faiss"
date: 2018-02-27T05:50:27.176Z
lastmod: 2019-06-16T18:17:55+09:00
category: dev
tags:
  - Python
---

faiss : Billion-scale similarity search with GPUs

![image](/posts/2018-02-27_how-to-install-faiss/images/1.png)

faiss : Billion-scale similarity search with GPUs

You mainly follow : [https://github.com/facebookresearch/faiss/blob/master/INSTALL.md](https://github.com/facebookresearch/faiss/blob/master/INSTALL.md)

Env : `Mac OS X 10.12.6`  
Not Tag, Note commit hash:`commit cd884114d0a8e1789f257b524e5345bc5b26e6b2`
``\_2018.02.24 : New version of Faiss!  
What&#39;s new?

- Support for on-disk inverted lists (see https://github.com/…/f…/blob/master/demos/demo_ondisk_ivf.py). Enables handling of datasets that do not fit in RAM. We tested it on up to 53B vectors, with a 2TB index.
- Tutorial and examples for using Faiss on one or more GPUs (see https://github.com/facebookresea…/faiss/wiki/Running-on-GPUs).
- Macports package (math/libfaiss) - more packages soon.
- Minor bug fixes.\_``

Let’s start.
`$ git clone https://github.com/facebookresearch/faiss.git $ cd faiss $ mv example_makefiles/makefile.inc.Mac.brew ./makefile.inc`

### Compile C++ faiss

- Firstly you install BLAS and LAPACK. : [Install BLAS,LAPACK](https://pheiter.wordpress.com/2012/09/04/howto-installing-lapack-and-blas-on-mac-os/)`` $ `brew install llvm `$ brew install gcc $ make tests/test_blas /usr/local/opt/llvm/bin/clang++ -fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -I/usr/local/opt/llvm/include -std=c++11 tests/test_blas.cpp -o tests/test_blas -g -fPIC -fopenmp -L/usr/local/opt/llvm/lib -L/usr/local/Cellar/llvm/5.0.1/lib -framework Accelerate -DFINTEGER=int````$ ./tests/test_blas BLAS test errors= 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 -0.000 -0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 -0.000 0.000 0.000 -0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 -0.000 -0.000 0.000 0.000 0.000 -0.000 -0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 -0.000 -0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 -0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 -0.000 -0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 -0.000 0.000 0.000 0.000 0.000 0.000 0.000 -0.000 0.000 0.000 0.000 -0.000 0.000 0.000 -0.000 -0.000 0.000 -0.000 0.000 -0.000 0.000 0.000 -0.000 Intentional Lapack error (appears only for 64-bit INTEGER): info=0000064b00000000 Lapack uses 32-bit integers ``

This is not error. : [link](https://github.com/facebookresearch/faiss/issues/101)
``\$ make  
/usr/local/opt/llvm/bin/clang++ -fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -I/usr/local/opt/llvm/include -std=c++11 -c hamming.cpp -o hamming.o`...`IndexScalarQuantizer.cpp -o IndexScalarQuantizer.o  
IndexScalarQuantizer.cpp:14:10: fatal error: &#39;malloc.h&#39; file not found

# include &lt;malloc.h&gt;

         ^~~~~~~~~~

1 error generated.  
make: \*\*\* [IndexScalarQuantizer.o] Error 1``

`IndexScalarQuantizer.cpp`
`# include &lt;malloc.h&gt;`

↓
`# include &lt;sys/malloc.h&gt;`

Ref ([https://tbr8.org/install-faiss-on-mac-os/](https://tbr8.org/install-faiss-on-mac-os/))
` $ make /usr/local/opt/llvm/bin/clang++ -fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -I/usr/local/opt/llvm/include -std=c++11 -c IndexScalarQuantizer.cpp -o IndexScalarQuantizer.o````...````ar: creating archive libfaiss.a /usr/local/opt/llvm/bin/clang++ -o demos/demo_ivfpq_indexing -fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -I/usr/local/opt/llvm/include -std=c++11 demos/demo_ivfpq_indexing.cpp libfaiss.a -g -fPIC -fopenmp -L/usr/local/opt/llvm/lib -L/usr/local/Cellar/llvm/5.0.1/lib -framework Accelerate````$ demos/demo_ivfpq_indexing [0.000 s] Generating 100000 vectors in 128D for training [0.165 s] Training the index Training level-1 quantizer Training level-1 quantizer on 100000 vectors in 128D Training IVF residual Input training set too big (max size is 65536), sampling 65536 / 100000 vectors computing residuals training 4x256 product quantizer on 65536 vectors in 128D Training PQ slice 0/4 Clustering 65536 points in 32D to 256 clusters, redo 1 times, 25 iterations Preprocessing in 0.01 s Iteration 24 (0.87 s, search 0.84 s): objective=113241 imbalance=1.004 nsplit=0 Training PQ slice 1/4 Clustering 65536 points in 32D to 256 clusters, redo 1 times, 25 iterations Preprocessing in 0.01 s Iteration 24 (0.84 s, search 0.81 s): objective=113353 imbalance=1.004 nsplit=0 Training PQ slice 2/4 Clustering 65536 points in 32D to 256 clusters, redo 1 times, 25 iterations Preprocessing in 0.01 s Iteration 24 (0.82 s, search 0.79 s): objective=113274 imbalance=1.004 nsplit=0 Training PQ slice 3/4 Clustering 65536 points in 32D to 256 clusters, redo 1 times, 25 iterations Preprocessing in 0.01 s Iteration 24 (0.88 s, search 0.86 s): objective=113141 imbalance=1.004 nsplit=0 precomputing IVFPQ tables type 1 [8.453 s] storing the pre-trained index to /tmp/index_trained.faissindex [8.456 s] Building a dataset of 200000 vectors to index [8.818 s] Adding the vectors to the index IndexIVFPQ::add_core_o: adding 0:32768 / 200000 add_core times: 157.094 111.340 4.048 IndexIVFPQ::add_core_o: adding 32768:65536 / 200000 add_core times: 161.185 104.820 2.199 IndexIVFPQ::add_core_o: adding 65536:98304 / 200000 add_core times: 156.851 105.808 2.865 IndexIVFPQ::add_core_o: adding 98304:131072 / 200000 add_core times: 163.588 113.381 2.311 IndexIVFPQ::add_core_o: adding 131072:163840 / 200000 add_core times: 195.370 110.669 2.505 IndexIVFPQ::add_core_o: adding 163840:196608 / 200000 add_core times: 155.380 106.777 2.499 IndexIVFPQ::add_core_o: adding 196608:200000 / 200000 add_core times: 18.895 11.918 0.296 [10.518 s] imbalance factor: 1.23721 [10.532 s] Searching the 5 nearest neighbors of 9 vectors in the index [10.533 s] Query results (vector ids, then distances): query 0: 1234 196783 151072 184097 59404 dis: 7.59448 8.73569 9.32671 9.40073 9.8221 query 1: 1235 143169 153018 103432 14870 dis: 6.70634 8.11071 8.82516 9.40931 9.43434 query 2: 1236 75075 188719 85363 10999 dis: 6.89075 9.39095 9.82474 9.92888 10.0297 query 3: 1237 16172 134049 105294 169581 dis: 8.32598 11.3405 11.4758 11.6785 11.7097 query 4: 1238 88419 108591 54396 52208 dis: 8.34287 10.4571 10.4597 11.1477 11.6777 query 5: 1239 43646 195506 35780 113330 dis: 7.46891 9.0416 9.65232 9.82861 9.84448 query 6: 1240 160333 170467 71739 61290 dis: 6.86489 9.4142 9.74915 9.81607 9.85242 query 7: 1241 115632 122785 168251 173845 dis: 6.05343 8.749 8.90397 9.01914 9.07404 query 8: 1242 78102 179175 37071 89957 dis: 7.46019 9.95651 10.0036 10.0071 10.1378 note that the nearest neighbor is not at distance 0 due to quantization errors `

### Python Interface

` $ make py /usr/local/opt/llvm/bin/clang++ -I. -fPIC -m64 -Wall -g -O3 -msse4 -mpopcnt -fopenmp -Wno-sign-compare -I/usr/local/opt/llvm/include -std=c++11 -g -fPIC -fopenmp -L/usr/local/opt/llvm/lib -L/usr/local/Cellar/llvm/5.0.1/lib -I/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7 -I/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy/core/include -Wl,-F. -bundle -undefined dynamic_lookup \ -o python/_swigfaiss.so python/swigfaiss_wrap.cxx libfaiss.a -framework Accelerate In file included from python/swigfaiss_wrap.cxx:3241: ./IndexHNSW.h:215:1: warning: &#39;IndexHNSW&#39; defined as a struct here but previously declared as a class [-Wmismatched-tags] struct IndexHNSW: Index { ^ ./IndexHNSW.h:169:1: note: did you mean struct here? class IndexHNSW; ^~~~~ struct 1 warning generated. cp python/_swigfaiss.so python/swigfaiss.py .````$ python -c &#34;import faiss&#34; Failed to load GPU Faiss: No module named swigfaiss_gpu Faiss falling back to CPU-only. `

Done!### LAPACK, BLAS ver.

- [http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)
- Download: lapack-3.8.0.tar.gz
- [http://www.netlib.org/blas/](http://www.netlib.org/blas/)
- Download blas-3.8.0.tgz

### Next.

Switch to wrapper of _Python3…_
