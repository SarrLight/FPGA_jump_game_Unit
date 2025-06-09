/******************************************************************************
 ** Logisim-evolution goes FPGA automatic generated Verilog code             **
 ** https://github.com/logisim-evolution/                                    **
 **                                                                          **
 ** Component : MyMC14495                                                    **
 **                                                                          **
 *****************************************************************************/

module MyMC14495( D0,
                  D1,
                  D2,
                  D3,
                  LE,
                  a,
                  b,
                  c,
                  d,
                  e,
                  f,
                  g,
                  p,
                  point );

   /*******************************************************************************
   ** The inputs are defined here                                                **
   *******************************************************************************/
   input D0;
   input D1;
   input D2;
   input D3;
   input LE;
   input point;

   /*******************************************************************************
   ** The outputs are defined here                                               **
   *******************************************************************************/
   output a;
   output b;
   output c;
   output d;
   output e;
   output f;
   output g;
   output p;

   /*******************************************************************************
   ** The wires are defined here                                                 **
   *******************************************************************************/
   wire s_logisimNet0;
   wire s_logisimNet1;
   wire s_logisimNet10;
   wire s_logisimNet11;
   wire s_logisimNet12;
   wire s_logisimNet13;
   wire s_logisimNet14;
   wire s_logisimNet15;
   wire s_logisimNet16;
   wire s_logisimNet17;
   wire s_logisimNet18;
   wire s_logisimNet19;
   wire s_logisimNet2;
   wire s_logisimNet20;
   wire s_logisimNet21;
   wire s_logisimNet22;
   wire s_logisimNet23;
   wire s_logisimNet24;
   wire s_logisimNet25;
   wire s_logisimNet26;
   wire s_logisimNet27;
   wire s_logisimNet28;
   wire s_logisimNet29;
   wire s_logisimNet3;
   wire s_logisimNet30;
   wire s_logisimNet31;
   wire s_logisimNet32;
   wire s_logisimNet33;
   wire s_logisimNet34;
   wire s_logisimNet35;
   wire s_logisimNet36;
   wire s_logisimNet37;
   wire s_logisimNet38;
   wire s_logisimNet39;
   wire s_logisimNet4;
   wire s_logisimNet40;
   wire s_logisimNet41;
   wire s_logisimNet42;
   wire s_logisimNet43;
   wire s_logisimNet44;
   wire s_logisimNet45;
   wire s_logisimNet5;
   wire s_logisimNet6;
   wire s_logisimNet7;
   wire s_logisimNet8;
   wire s_logisimNet9;

   /*******************************************************************************
   ** The module functionality is described here                                 **
   *******************************************************************************/

   /*******************************************************************************
   ** Here all input connections are defined                                     **
   *******************************************************************************/
   assign s_logisimNet0  = LE;
   assign s_logisimNet1  = D0;
   assign s_logisimNet15 = D3;
   assign s_logisimNet2  = D1;
   assign s_logisimNet27 = point;
   assign s_logisimNet3  = D2;

   /*******************************************************************************
   ** Here all output connections are defined                                    **
   *******************************************************************************/
   assign a = s_logisimNet22;
   assign b = s_logisimNet42;
   assign c = s_logisimNet43;
   assign d = s_logisimNet40;
   assign e = s_logisimNet44;
   assign f = s_logisimNet30;
   assign g = s_logisimNet12;
   assign p = s_logisimNet9;

   /*******************************************************************************
   ** Here all in-lined components are defined                                   **
   *******************************************************************************/

   // NOT Gate
   assign s_logisimNet6 = ~s_logisimNet1;

   // NOT Gate
   assign s_logisimNet9 = ~s_logisimNet27;

   // NOT Gate
   assign s_logisimNet5 = ~s_logisimNet3;

   // NOT Gate
   assign s_logisimNet18 = ~s_logisimNet2;

   // NOT Gate
   assign s_logisimNet8 = ~s_logisimNet15;

   /*******************************************************************************
   ** Here all normal components are defined                                     **
   *******************************************************************************/
   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A10 (.input1(s_logisimNet2),
           .input2(s_logisimNet15),
           .input3(s_logisimNet6),
           .input4(s_logisimNet5),
           .result(s_logisimNet36));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_2 (.input1(s_logisimNet0),
               .input2(s_logisimNet32),
               .result(s_logisimNet40));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A11 (.input1(s_logisimNet1),
           .input2(s_logisimNet2),
           .input3(s_logisimNet3),
           .result(s_logisimNet28));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_4 (.input1(s_logisimNet36),
               .input2(s_logisimNet28),
               .input3(s_logisimNet20),
               .input4(s_logisimNet17),
               .result(s_logisimNet32));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A12 (.input1(s_logisimNet2),
           .input2(s_logisimNet3),
           .input3(s_logisimNet15),
           .result(s_logisimNet35));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A13 (.input1(s_logisimNet2),
           .input2(s_logisimNet6),
           .input3(s_logisimNet5),
           .input4(s_logisimNet8),
           .result(s_logisimNet21));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_7 (.input1(s_logisimNet0),
               .input2(s_logisimNet33),
               .result(s_logisimNet43));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A14 (.input1(s_logisimNet1),
           .input2(s_logisimNet2),
           .input3(s_logisimNet15),
           .result(s_logisimNet23));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_9 (.input1(s_logisimNet35),
               .input2(s_logisimNet21),
               .input3(s_logisimNet29),
               .result(s_logisimNet33));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A15 (.input1(s_logisimNet3),
           .input2(s_logisimNet15),
           .input3(s_logisimNet6),
           .result(s_logisimNet29));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A16 (.input1(s_logisimNet2),
           .input2(s_logisimNet3),
           .input3(s_logisimNet6),
           .result(s_logisimNet24));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_12 (.input1(s_logisimNet0),
                .input2(s_logisimNet34),
                .result(s_logisimNet42));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A17 (.input1(s_logisimNet1),
           .input2(s_logisimNet3),
           .input3(s_logisimNet18),
           .input4(s_logisimNet8),
           .result(s_logisimNet13));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_14 (.input1(s_logisimNet23),
                .input2(s_logisimNet29),
                .input3(s_logisimNet24),
                .input4(s_logisimNet13),
                .result(s_logisimNet34));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A18 (.input1(s_logisimNet1),
           .input2(s_logisimNet2),
           .input3(s_logisimNet15),
           .input4(s_logisimNet5),
           .result(s_logisimNet11));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A19 (.input1(s_logisimNet1),
           .input2(s_logisimNet3),
           .input3(s_logisimNet15),
           .input4(s_logisimNet18),
           .result(s_logisimNet10));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_17 (.input1(s_logisimNet0),
                .input2(s_logisimNet45),
                .result(s_logisimNet22));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A20 (.input1(s_logisimNet3),
           .input2(s_logisimNet6),
           .input3(s_logisimNet18),
           .input4(s_logisimNet8),
           .result(s_logisimNet20));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_19 (.input1(s_logisimNet11),
                .input2(s_logisimNet10),
                .input3(s_logisimNet20),
                .input4(s_logisimNet17),
                .result(s_logisimNet45));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A21 (.input1(s_logisimNet1),
           .input2(s_logisimNet18),
           .input3(s_logisimNet5),
           .input4(s_logisimNet8),
           .result(s_logisimNet17));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A1 (.input1(s_logisimNet3),
          .input2(s_logisimNet15),
          .input3(s_logisimNet6),
          .input4(s_logisimNet18),
          .result(s_logisimNet4));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_22 (.input1(s_logisimNet0),
                .input2(s_logisimNet39),
                .result(s_logisimNet12));

   AND_GATE_4_INPUTS #(.BubblesMask(4'h0))
      A2 (.input1(s_logisimNet1),
          .input2(s_logisimNet2),
          .input3(s_logisimNet3),
          .input4(s_logisimNet8),
          .result(s_logisimNet7));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_24 (.input1(s_logisimNet4),
                .input2(s_logisimNet7),
                .input3(s_logisimNet16),
                .result(s_logisimNet39));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A3 (.input1(s_logisimNet18),
          .input2(s_logisimNet5),
          .input3(s_logisimNet8),
          .result(s_logisimNet16));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A4 (.input1(s_logisimNet1),
          .input2(s_logisimNet2),
          .input3(s_logisimNet8),
          .result(s_logisimNet26));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_27 (.input1(s_logisimNet0),
                .input2(s_logisimNet19),
                .result(s_logisimNet30));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A5 (.input1(s_logisimNet2),
          .input2(s_logisimNet5),
          .input3(s_logisimNet8),
          .result(s_logisimNet14));

   OR_GATE_4_INPUTS #(.BubblesMask(4'h0))
      GATES_29 (.input1(s_logisimNet26),
                .input2(s_logisimNet14),
                .input3(s_logisimNet25),
                .input4(s_logisimNet10),
                .result(s_logisimNet19));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A6 (.input1(s_logisimNet1),
          .input2(s_logisimNet5),
          .input3(s_logisimNet8),
          .result(s_logisimNet25));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A7 (.input1(s_logisimNet1),
          .input2(s_logisimNet18),
          .input3(s_logisimNet5),
          .result(s_logisimNet38));

   OR_GATE #(.BubblesMask(2'b00))
      GATES_32 (.input1(s_logisimNet0),
                .input2(s_logisimNet31),
                .result(s_logisimNet44));

   AND_GATE_3_INPUTS #(.BubblesMask(3'b000))
      A8 (.input1(s_logisimNet3),
          .input2(s_logisimNet18),
          .input3(s_logisimNet8),
          .result(s_logisimNet41));

   OR_GATE_3_INPUTS #(.BubblesMask(3'b000))
      GATES_34 (.input1(s_logisimNet38),
                .input2(s_logisimNet41),
                .input3(s_logisimNet37),
                .result(s_logisimNet31));

   AND_GATE #(.BubblesMask(2'b00))
      A9 (.input1(s_logisimNet1),
          .input2(s_logisimNet8),
          .result(s_logisimNet37));


endmodule
