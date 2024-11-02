`define	INT8		8
`define	INT16		16
`define	INT32		32
`define	LENGTH	16

//`define	SCALAR_WIDTH	32
//`define	DATA_WIDTH	8
//`define	VECTOR_SIZ	16//8

//vector register index
`define	index_0	((`LENGTH - 15)*`INT8-1):`INT8*0
`define	index_1	((`LENGTH - 14)*`INT8-1):`INT8*1
`define	index_2	((`LENGTH - 13)*`INT8-1):`INT8*2
`define	index_3	((`LENGTH - 12)*`INT8-1):`INT8*3
`define	index_4	((`LENGTH - 11)*`INT8-1):`INT8*4
`define	index_5	((`LENGTH - 10)*`INT8-1):`INT8*5
`define	index_6	((`LENGTH - 9)*`INT8-1):`INT8*6
`define	index_7	((`LENGTH - 8)*`INT8-1):`INT8*7

//`define	index_0	((`VECTOR_SIZ - 7)*`DATA_WIDTH-1):`DATA_WIDTH*0
//`define	index_1	((`VECTOR_SIZ - 6)*`DATA_WIDTH-1):`DATA_WIDTH*1
//`define	index_2	((`VECTOR_SIZ - 5)*`DATA_WIDTH-1):`DATA_WIDTH*2
//`define	index_3	((`VECTOR_SIZ - 4)*`DATA_WIDTH-1):`DATA_WIDTH*3
//`define	index_4	((`VECTOR_SIZ - 3)*`DATA_WIDTH-1):`DATA_WIDTH*4
//`define	index_5	((`VECTOR_SIZ - 2)*`DATA_WIDTH-1):`DATA_WIDTH*5
//`define	index_6	((`VECTOR_SIZ - 1)*`DATA_WIDTH-1):`DATA_WIDTH*6
//`define	index_7	((`VECTOR_SIZ - 0)*`DATA_WIDTH-1):`DATA_WIDTH*7

`define	index_8	((`LENGTH - 7)*`INT8-1):`INT8*8
`define	index_9	((`LENGTH - 6)*`INT8-1):`INT8*9
`define	index_10	((`LENGTH - 5)*`INT8-1):`INT8*10
`define	index_11	((`LENGTH - 4)*`INT8-1):`INT8*11
`define	index_12	((`LENGTH - 3)*`INT8-1):`INT8*12
`define	index_13	((`LENGTH - 2)*`INT8-1):`INT8*13
`define	index_14	((`LENGTH - 1)*`INT8-1):`INT8*14
`define	index_15	((`LENGTH - 0)*`INT8-1):`INT8*15



`define	index16_0	((`LENGTH - 15)*`INT16-1):`INT16*0
`define	index16_1	((`LENGTH - 14)*`INT16-1):`INT16*1
`define	index16_2	((`LENGTH - 13)*`INT16-1):`INT16*2
`define	index16_3	((`LENGTH - 12)*`INT16-1):`INT16*3
`define	index16_4	((`LENGTH - 11)*`INT16-1):`INT16*4
`define	index16_5	((`LENGTH - 10)*`INT16-1):`INT16*5
`define	index16_6	((`LENGTH - 9)*`INT16-1):`INT16*6
`define	index16_7	((`LENGTH - 8)*`INT16-1):`INT16*7
`define	index16_8	((`LENGTH - 7)*`INT16-1):`INT16*8
`define	index16_9	((`LENGTH - 6)*`INT16-1):`INT16*9
`define	index16_10	((`LENGTH - 5)*`INT16-1):`INT16*10
`define	index16_11	((`LENGTH - 4)*`INT16-1):`INT16*11
`define	index16_12	((`LENGTH - 3)*`INT16-1):`INT16*12
`define	index16_13	((`LENGTH - 2)*`INT16-1):`INT16*13
`define	index16_14	((`LENGTH - 1)*`INT16-1):`INT16*14
`define	index16_15	((`LENGTH - 0)*`INT16-1):`INT16*15