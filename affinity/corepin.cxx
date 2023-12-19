
// Keep std::threads from running until parametrization
// of the underlying native POSIX threads is done.
// Ramp up the process by assigning threads their specific
// cores, priorities and wake them up.
// This is important in a high performance setup where
// cores are saturated by high load and/or polling threads.

// Wake up is done via a condition variable.
// Shared future/promise is a high level way to achieve this.

// sudo setcap 'cap_sys_nice=eip' ./corepin 
// needed to change thread priorities

// ps -o pid,psr,comm -p <pid>
// see cores assigned


#include <pthread.h>
#include <sched.h>
#include <unistd.h>
#include <ctime>

#include <vector>
#include <chrono>
#include <condition_variable>
#include <iostream>
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
int cvsignal = 0;

 
void fn(const int index)
{
    std::unique_lock<std::mutex> lock(cvmutex);
    std::cout << "Thread #" << index << " waiting on CPU " << ::sched_getcpu() << std::endl;
    cv.wait(lock, []{ return cvsignal == 1; });
    
    {
        std::lock_guard<std::mutex> lock(iomutex);
        std::cout << "Thread #" << index << " running on CPU " << ::sched_getcpu() << std::endl;
    }

    lock.unlock();
    
    for (auto i{0}; i< 10; i++) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}
 
 
int main()
{
    const int num_threads = std::thread::hardware_concurrency();

    std::vector< std::thread > threads;

    for (auto i{0}; i < num_threads; i++) {
        threads.push_back(std::thread(fn, i));
    }
    
    // Do the POSIX thread stuff here
    //

    // Thread affinities/core pinning
    cpu_set_t cpuset{};

    for (auto i{0}; i < num_threads; ++i) {   
        CPU_ZERO(&cpuset);
        CPU_SET(i, &cpuset);
        ::pthread_setaffinity_np(threads[i].native_handle(), sizeof(cpu_set_t), &cpuset);
    }
    
    // Thread priorities
    // sched_param schedule;
    // int policy; 
    // ::pthread_getschedparam(threads[1].native_handle(), &policy, &schedule);
    // schedule.sched_priority = 20;
    // ::pthread_setschedparam(threads[1].native_handle(), SCHED_FIFO, &schedule);
    
 
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