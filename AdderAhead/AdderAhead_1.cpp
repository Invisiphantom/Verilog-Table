#include "VAdderAhead_1.h"
#include "verilated_vcd_c.h"
#include <iostream>

using namespace std;

vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    VerilatedVcdC *tfp = new VerilatedVcdC;
    tfp->open("wave.vcd");

    VAdderAhead_1 *top = new VAdderAhead_1;
    top->trace(tfp, 0);


    while (main_time < 100 && !Verilated::gotFinish()) {
        auto a_i = top->a_i;
        auto b_i = top->b_i;
        auto cin_i = top->cin_i;

        switch (main_time) {
        case 0: // 0+0+0=00
            a_i = 0;
            b_i = 0;
            cin_i = 0;
            break;
        case 10: // 1+0+0=01
            a_i = 1;
            b_i = 0;
            cin_i = 0;
            break;
        case 20: // 0+1+0=01
            a_i = 0;
            b_i = 1;
            cin_i = 0;
            break;
        case 30: // 1+1+0=10
            a_i = 1;
            b_i = 1;
            cin_i = 0;
            break;
        case 40: // 1+1+1=11
            a_i = 1;
            b_i = 1;
            cin_i = 1;
            break;
        default:
            break;
        }

        top->a_i = a_i;
        top->b_i = b_i;
        top->cin_i = cin_i;

        top->eval();
        tfp->dump(main_time);
        main_time++;
    }

    top->final();
    tfp->close();
    delete top;
    return 0;
}