LC1:
        .string "default"
getTime():
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     QWORD PTR [rbp-16], 0
        mov     QWORD PTR [rbp-8], 0
        lea     rax, [rbp-16]
        mov     rsi, rax
        mov     edi, 0
        call    clock_gettime
        mov     rax, QWORD PTR [rbp-16]
        imul    rax, rax, 1000000000
        mov     rdx, QWORD PTR [rbp-8]
        add     rax, rdx
        leave
        ret
main:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 1610120
        mov     DWORD PTR [rbp-24], 100000
        lea     rax, [rbp-1605088]
        mov     rdi, rax
        call    std::random_device::random_device() [complete object constructor]
        lea     rax, [rbp-1605088]
        mov     rdi, rax
        call    std::random_device::operator()()
        mov     edx, eax
        lea     rax, [rbp-1610096]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>::mersenne_twister_engine(unsigned long) [complete object constructor]
        movsd   xmm0, QWORD PTR .LC2[rip]
        mov     rdx, QWORD PTR .LC3[rip]
        lea     rax, [rbp-1610128]
        movapd  xmm1, xmm0
        movq    xmm0, rdx
        mov     rdi, rax
        call    std::normal_distribution<double>::normal_distribution(double, double) [complete object constructor]
        mov     DWORD PTR [rbp-20], 0
        jmp     .L20
.L21:
        lea     rdx, [rbp-1610096]
        lea     rax, [rbp-1610128]
        mov     rsi, rdx
        mov     rdi, rax
        call    double std::normal_distribution<double>::operator()<std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul> >(std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>&)
        movq    rbx, xmm0
        mov     eax, DWORD PTR [rbp-20]
        movsx   rdx, eax
        lea     rax, [rbp-800080]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::array<double, 100000ul>::operator[](unsigned long)
        mov     QWORD PTR [rax], rbx
        lea     rdx, [rbp-1610096]
        lea     rax, [rbp-1610128]
        mov     rsi, rdx
        mov     rdi, rax
        call    double std::normal_distribution<double>::operator()<std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul> >(std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>&)
        movq    rbx, xmm0
        mov     eax, DWORD PTR [rbp-20]
        movsx   rdx, eax
        lea     rax, [rbp-1600080]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::array<double, 100000ul>::operator[](unsigned long)
        mov     QWORD PTR [rax], rbx
        add     DWORD PTR [rbp-20], 1
.L20:
        cmp     DWORD PTR [rbp-20], 99999
        jle     .L21
        lea     rax, [rbp-80]
        lea     rdx, [rbp-800080]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::tuple<double, double, double> minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)
        lea     rax, [rbp-80]
        mov     rdi, rax
        call    std::tuple_element<0ul, std::tuple<double, double, double> >::type&& std::get<0ul, double, double, double>(std::tuple<double, double, double>&&)
        mov     rax, QWORD PTR [rax]
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:_ZSt4cout
        call    std::basic_ostream<char, std::char_traits<char> >::operator<<(double)
        mov     esi, OFFSET FLAT:_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
        mov     rdi, rax
        call    std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        lea     rax, [rbp-48]
        lea     rdx, [rbp-1600080]
        mov     rsi, rdx
        mov     rdi, rax
        call    std::tuple<double, double, double> minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)
        lea     rax, [rbp-48]
        mov     rdi, rax
        call    std::tuple_element<1ul, std::tuple<double, double, double> >::type&& std::get<1ul, double, double, double>(std::tuple<double, double, double>&&)
        mov     rax, QWORD PTR [rax]
        movq    xmm0, rax
        mov     edi, OFFSET FLAT:_ZSt4cout
        call    std::basic_ostream<char, std::char_traits<char> >::operator<<(double)
        mov     esi, OFFSET FLAT:_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_
        mov     rdi, rax
        call    std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))
        mov     ebx, 0
        lea     rax, [rbp-1605088]
        mov     rdi, rax
        call    std::random_device::~random_device() [complete object destructor]
        mov     eax, ebx
        jmp     .L25
        mov     rbx, rax
        lea     rax, [rbp-1605088]
        mov     rdi, rax
        call    std::random_device::~random_device() [complete object destructor]
        mov     rax, rbx
        mov     rdi, rax
        call    _Unwind_Resume
.L25:
        mov     rbx, QWORD PTR [rbp-8]
        leave
        ret
.LC4:
        .string "basic_string: construction from null is not valid"
std::tuple<double, double, double> minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&):
        push    rbp
        mov     rbp, rsp
        sub     rsp, 80
        mov     QWORD PTR [rbp-72], rdi
        mov     QWORD PTR [rbp-80], rsi
        movsd   xmm0, QWORD PTR .LC6[rip]
        movsd   QWORD PTR [rbp-56], xmm0
        movsd   xmm0, QWORD PTR .LC7[rip]
        movsd   QWORD PTR [rbp-64], xmm0
        pxor    xmm0, xmm0
        movsd   QWORD PTR [rbp-8], xmm0
        mov     rax, QWORD PTR [rbp-80]
        mov     QWORD PTR [rbp-48], rax
        lea     rax, [rbp-56]
        mov     QWORD PTR [rbp-40], rax
        lea     rax, [rbp-64]
        mov     QWORD PTR [rbp-32], rax
        movsd   xmm0, QWORD PTR [rbp-8]
        movsd   QWORD PTR [rbp-24], xmm0
        lea     rax, [rbp-48]
        mov     r8d, 0
        mov     ecx, 3
        mov     edx, 0
        mov     rsi, rax
        mov     edi, OFFSET FLAT:std::tuple<double, double, double> minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&) [clone ._omp_fn.0]
        call    GOMP_parallel_sections
        movsd   xmm0, QWORD PTR [rbp-24]
        movsd   QWORD PTR [rbp-8], xmm0
        movsd   xmm0, QWORD PTR [rbp-8]
        movsd   xmm1, QWORD PTR .LC8[rip]
        divsd   xmm0, xmm1
        movsd   QWORD PTR [rbp-16], xmm0
        mov     rax, QWORD PTR [rbp-72]
        lea     rcx, [rbp-16]
        lea     rdx, [rbp-64]
        lea     rsi, [rbp-56]
        mov     rdi, rax
        call    std::tuple<std::__strip_reference_wrapper<std::decay<double&>::type>::__type, std::__strip_reference_wrapper<std::decay<double&>::type>::__type, std::__strip_reference_wrapper<std::decay<double>::type>::__type> std::make_tuple<double&, double&, double>(double&, double&, double&&)
        mov     rax, QWORD PTR [rbp-72]
        leave
        ret
auto minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#1}::operator()<double>(double) const:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        movsd   QWORD PTR [rbp-16], xmm0
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        movsd   xmm0, QWORD PTR [rax]
        comisd  xmm0, QWORD PTR [rbp-16]
        ja      .L82
        jmp     .L83
.L82:
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        movsd   xmm0, QWORD PTR [rbp-16]
        movsd   QWORD PTR [rax], xmm0
.L83:
        nop
        pop     rbp
        ret
auto minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#2}::operator()<double>(double) const:
        push    rbp
        mov     rbp, rsp
        mov     QWORD PTR [rbp-8], rdi
        movsd   QWORD PTR [rbp-16], xmm0
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        movsd   xmm1, QWORD PTR [rax]
        movsd   xmm0, QWORD PTR [rbp-16]
        comisd  xmm0, xmm1
        ja      .L91
        jmp     .L92
.L91:
        mov     rax, QWORD PTR [rbp-8]
        mov     rax, QWORD PTR [rax]
        movsd   xmm0, QWORD PTR [rbp-16]
        movsd   QWORD PTR [rax], xmm0
.L92:
        nop
        pop     rbp
        ret
std::tuple<double, double, double> minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&) [clone ._omp_fn.0]:
        push    rbp
        mov     rbp, rsp
        push    r12
        push    rbx
        sub     rsp, 16
        mov     QWORD PTR [rbp-24], rdi
        call    GOMP_sections_next
.L177:
        cmp     eax, 3
        je      .L172
        cmp     eax, 3
        ja      .L173
        cmp     eax, 2
        je      .L174
        cmp     eax, 2
        ja      .L173
        test    eax, eax
        je      .L175
        cmp     eax, 1
        je      .L176
.L173:
        ud2
.L175:
        call    GOMP_sections_end_nowait
        jmp     .L179
.L178:
        call    GOMP_sections_next
        jmp     .L177
.L172:
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::end() const
        mov     rbx, rax
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::begin() const
        mov     rdx, rax
        mov     rax, QWORD PTR .LC5[rip]
        movq    xmm0, rax
        mov     rsi, rbx
        mov     rdi, rdx
        call    double std::accumulate<double const*, double>(double const*, double const*, double)
        movq    rax, xmm0
        mov     rdx, QWORD PTR [rbp-24]
        mov     QWORD PTR [rdx+24], rax
        jmp     .L178
.L174:
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax+16]
        mov     r12, rax
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::end() const
        mov     rbx, rax
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::begin() const
        mov     rdx, r12
        mov     rsi, rbx
        mov     rdi, rax
        call    minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#2} std::for_each<double const*, minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#2}>(double const*, double const*, minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#2})
        jmp     .L178
.L176:
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax+8]
        mov     r12, rax
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::end() const
        mov     rbx, rax
        mov     rax, QWORD PTR [rbp-24]
        mov     rax, QWORD PTR [rax]
        mov     rdi, rax
        call    std::array<double, 100000ul>::begin() const
        mov     rdx, r12
        mov     rsi, rbx
        mov     rdi, rax
        call    minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#1} std::for_each<double const*, minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#1}>(double const*, double const*, minmaxavg<double, 100000ul>(std::array<double, 100000ul> const&)::{lambda(auto:1)#1})
        jmp     .L178
.L179:
        add     rsp, 16
        pop     rbx
        pop     r12
        pop     rbp
        ret
.LC2:
        .long   0
        .long   1073741824
.LC3:
        .long   0
        .long   1075052544
.LC5:
        .long   0
        .long   0
.LC6:
        .long   -1
        .long   2146435071
.LC7:
        .long   0
        .long   1048576
.LC8:
        .long   0
        .long   1090021888
.LC9:
        .long   0
        .long   1072693248
.LC10:
        .long   0
        .long   -1073741824
.LC11:
        .long   0
        .long   -2147483648
        .long   16415
        .long   0
.LC12:
        .long   0
        .long   -2147483648
        .long   16384
        .long   0
.LC13:
        .long   0
        .long   -2147483648
        .long   16446
        .long   0
.LC14:
        .long   -1
        .long   1072693247
