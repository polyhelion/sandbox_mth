
// Keep std::threads from running until parametrization
// of the underlying native POSIX threads is done.
// Ramp up the process by assigning threads their specific
// cores, priorities and wake them up.
// This is important in a high performance setup where
// cores are saturated by high load and/or polling threads.

// Wake up is done via a condition variable.
// Shared future/promise is a high level way to achieve this.

// Usage:

// Allow core pinning
// $ sudo setcap 'cap_sys_nice=eip' ./corepin 
// Run the program
// $ ./corepin

// See cores assigned
// $ ps -o pid,psr,comm -p <pid>



#include <pthread.h>
#include <sched.h>
#include <unistd.h>
#include <ctime>

#include <vector>
#include <chrono>
#include <condition_variable>
#include <cstdio>
#include <thread>
 


// Some instrumentation
#if defined NDEBUG
# define ASSERT_EQ0(X) void(0)
#else
# define ASSERT_EQ0(X) \
    ( (X == 0) ? void(0) : []{assert(#X " != 0");}() )
#endif



// High precision timestamps (ns on Linux machines)
uint64_t utc_ns() {
    std::timespec val{};
    constexpr uint64_t NS_PER_SEC = 1000000000ULL;
    ::clock_gettime( CLOCK_REALTIME, &val );
    return (uint64_t)( (uint64_t)val.tv_sec * NS_PER_SEC ) + (uint64_t)val.tv_nsec;
}


std::condition_variable cv;
std::mutex cvmutex, iomutex; 
int cvsignal{0};

 
void fn(const int index)
{
    std::unique_lock<std::mutex> lock(cvmutex);
    std::printf("Thread #%d waiting on CPU %d \n", index, ::sched_getcpu());
    cv.wait(lock, []{ return cvsignal == 1; });
    
    {
        std::lock_guard<std::mutex> lock(iomutex);
        std::printf("Thread #%d running on CPU %d \n", index, ::sched_getcpu());
    }

    lock.unlock();
    
    for (int i{0}; i< 10; i++) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}
 
 
int main()
{
    const int num_threads = std::thread::hardware_concurrency();

    std::vector< std::thread > threads;

    for (int i{0}; i < num_threads; i++) {
        threads.push_back(std::thread(fn, i));
    }
    
    // Do the POSIX thread stuff here
    //

    // Thread affinities/core pinning
    std::vector<cpu_set_t> cpusets;

    for (int i{0}; i < num_threads; ++i) {   
        cpu_set_t cpuset{};
        CPU_ZERO(&cpuset);
        CPU_SET(i, &cpuset);
        ::pthread_setaffinity_np(threads[i].native_handle(), sizeof(cpu_set_t), &cpuset);
        cpusets.push_back(cpuset);
    }

    // Thread priorities
    // sched_param schedule;
    // int policy; 
    // ::pthread_getschedparam(threads[1].native_handle(), &policy, &schedule);
    // schedule.sched_priority = 20;
    // ::pthread_setschedparam(threads[1].native_handle(), SCHED_FIFO, &schedule);
    
    // Verify that the core assignment was applied by the scheduler
    cpu_set_t current_affinity{};
    int cpu;

    for (int i{0}; i < num_threads; ++i) {  
        CPU_ZERO(&current_affinity);
        ::pthread_getaffinity_np(threads[i].native_handle(), sizeof(cpu_set_t), &current_affinity);

        if (CPU_EQUAL(&cpusets[i], &current_affinity)) {
            std::printf("Thread #%d successfully pinned to core(s) : ", i);
// Works for glibc >= 2.34  
//            CPU_FOREACH(cpu, &cpusets[i]) {
//            	std::printf("%d ", cpu);
//            }
	    for(cpu = 0; cpu <  CPU_SETSIZE; ++cpu) {
	    	if (CPU_ISSET(cpu, &cpusets[i])) {
	    		std::printf("%d ", cpu);
	    	}
	    }
            std::printf("\n");
        } else {
            std::printf("Affinity setting not yet active ! \n");
            // add some more logic here
        }
    }

    {
        std::lock_guard<std::mutex> lock(cvmutex);
        cvsignal = 1;
    }
    cv.notify_all();  // Wake up in a certain order ? 


    for (auto& thread : threads) {    
        if ( thread.joinable() ) { thread.join(); }
    }
    

    return 0;
}
