`define NOP		5'b00000	//0

`define LOADV	5'b00001	//1
`define LOADS	5'b00010	//2
`define LOADI	5'b00011	//3
`define STOREV	5'b00100	//4
`define STORES	5'b00101	//5

`define B		5'b00110	//6
`define BEQ		5'b00111	//7
`define BGT		5'b01000	//8
`define JUMP	5'b01001	//9

`define ADDV	5'b01010	//10
`define ADDVS	5'b01011	//11
`define ADDSS	5'b01100	//12
`define SUBV	5'b01101	//13
`define SUBVS	5'b01110	//14
`define SUBSS	5'b01111	//15
`define MULV	5'b10000	//16
`define MULVS	5'b10001	//17
`define MULSS	5'b10010	//18
`define CMP		5'b10011	//19

`define ReLU	5'b10100	//20

//`define MOVV	5'd20
//`define MOVS	5'd21

`define addvs	4'b0001		//v
`define addss	4'b0010
`define subvs	4'b0011		//v
`define subss	4'b0100
`define mulvs	4'b0101		//v
`define mulss	4'b0110
`define relu	4'b0111		//v
`define addvv	4'b1000		//v
`define subvv	4'b1001		//v

`define mulvv	4'b1010	//Convolution
