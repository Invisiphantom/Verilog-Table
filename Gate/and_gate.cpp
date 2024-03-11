#include "Vand_gate.h"
#include <iostream>
#include <verilated_vcd_c.h>

using namespace std;

vluint64_t main_time = 0;
double sc_time_stamp() { return main_time; }

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    VerilatedVcdC *tfp = new VerilatedVcdC();
    Vand_gate *top = new Vand_gate("top");
    top->trace(tfp, 0);
    tfp->open("wave.vcd");

    for (; main_time < 20 && !Verilated::gotFinish(); main_time++) {
        auto a = top->a;
        auto b = top->b;

        switch (main_time) {
        case 0:
            a = 0;
            b = 0;
            break;
        case 5:
            a = 1;
            b = 0;
            break;
        case 10:
            a = 0;
            b = 1;
            break;
        case 15:
            a = 1;
            b = 1;
            break;
        default:
            break;
        }

        top->a = a;
        top->b = b;

        top->eval();
        tfp->dump(main_time);
        printf("%ld: a = %d, b = %d, f = %d\n", main_time, a, b, top->f);
    }
}