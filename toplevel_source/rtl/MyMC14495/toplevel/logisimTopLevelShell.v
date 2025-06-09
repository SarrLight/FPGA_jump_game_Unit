/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : logisimTopLevelShell                                         **
 **                                                                          **
 *****************************************************************************/

module logisimTopLevelShell(  );

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_D0;
   wire s_D1;
   wire s_D2;
   wire s_D3;
   wire s_LE;
   wire s_a;
   wire s_b;
   wire s_c;
   wire s_d;
   wire s_e;
   wire s_f;
   wire s_g;
   wire s_p;
   wire s_point;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** All signal adaptations are performed here                                  **
   *******************************************************************************/
   assign s_D0    = 1'b0;
   assign s_D1    = 1'b0;
   assign s_D2    = 1'b0;
   assign s_D3    = 1'b0;
   assign s_LE    = 1'b0;
   assign s_point = 1'b0;

   /*******************************************************************************
   ** The toplevel component is connected here                                   **
   *******************************************************************************/
   MyMC14495   CIRCUIT_0 (.D0(s_D0),
                          .D1(s_D1),
                          .D2(s_D2),
                          .D3(s_D3),
                          .LE(s_LE),
                          .a(s_a),
                          .b(s_b),
                          .c(s_c),
                          .d(s_d),
                          .e(s_e),
                          .f(s_f),
                          .g(s_g),
                          .p(s_p),
                          .point(s_point));
endmodule
