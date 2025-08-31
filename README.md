# sandbox_mth
Some experiments with C++ concurrency.

## affinity 

Keep std::threads from running until parametrization
of the underlying native POSIX threads is done.
Ramp up the process by assigning threads their specific
cores, priorities and wake them up.
This is important in a high performance setup where
cores are saturated by high load and/or polling threads.

## numeric

Some OpenMP observations.

