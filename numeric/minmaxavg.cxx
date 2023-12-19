
#include <algorithm>
#include <array>
#include <tuple>
#include <numeric>
#include <iostream>
#include <random>
#include <ctime> 


// High precision timestamps (ns on Linux machines)
uint64_t utc_ns() {
    std::timespec val{};
    constexpr uint64_t NS_PER_SEC = 1000000000ULL;
    ::clock_gettime( CLOCK_REALTIME, &val );
    return (uint64_t)( (uint64_t)val.tv_sec * NS_PER_SEC ) + (uint64_t)val.tv_nsec;
}


template<typename T, size_t N> 
std::tuple<T,T,T> minmaxavg(const std::array<T,N>& arr) {

    auto min = std::numeric_limits<T>::max(); 
    auto max = std::numeric_limits<T>::min(); 
    auto sum = T(0);

#pragma omp parallel sections
    {
#pragma omp section
        std::for_each(arr.begin(), arr.end(), [&min](auto d){ if (d < min) min = d; });
#pragma omp section
        std::for_each(arr.begin(), arr.end(), [&max](auto d){ if (d > max) max = d; });
#pragma omp section
        sum = std::accumulate(arr.begin(), arr.end(), T(0));
    }
    
    return std::make_tuple(min, max, sum / N); 

}



int main() {

    const int num_samples = 100000;

    std::array<double, num_samples> x; // __attribute__((__aligned__(32))) 
    std::array<double, num_samples> y; // __attribute__((__aligned__(32)))

    std::random_device rd; 
    std::mt19937 gen(rd()); 

    std::normal_distribution<double> d{5, 2};

    for (auto i{0}; i < num_samples; ++i) {

        x[i] = d(gen);
        y[i] = d(gen);
    }

    std::cout << std::get<0>(minmaxavg(x)) << std::endl;
    std::cout << std::get<1>(minmaxavg(y)) << std::endl;

    return 0;
}