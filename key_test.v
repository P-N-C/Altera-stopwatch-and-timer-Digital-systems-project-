module teclado(clk, in, out, decimalsaida, teste, teste1, teste2);

	input clk;
	input [3:0] in;
	output reg [3:0] out;
	output reg [15:0] decimalsaida;
	output reg teste, teste1, teste2;
	reg [15:0] decimal_aux;
	reg [1:0] state;
	parameter[1:0] coluna0 = 2'b00, coluna1 = 2'b01, coluna2 = 2'b10, debouncing = 2'b11;
	parameter[3:0] tecla_1 = 4'b0111, tecla_4 = 4'b1011, tecla_7 = 4'b1101,
				   tecla_2 = 4'b0111, tecla_5 = 4'b1011, tecla_8 = 4'b1101, tecla_0 = 4'b1110,
				   tecla_3 = 4'b0111, tecla_6 = 4'b1011, tecla_9 = 4'b1101, tecla_esp = 4'b1110;

	reg[19:0] count;
	reg[19:0] count_aux;
	
	reg[1:0] state_anterior;
	

	always @(posedge clk) begin
		case(state)
			coluna0: begin
				out <= 4'b0111;
				case(in)
					tecla_1: begin
						teste <= ~teste;
					end
					tecla_4: begin
						teste <= ~teste;
					end
					tecla_7: begin
						teste <= ~teste;
					end
					default: begin
						teste <= ~teste;
					end
				endcase
				state <= coluna1;
			end
			coluna1: begin
				out <= 4'b1011;
				case(in)
					tecla_2: begin
						teste1 <= ~teste1;
					end
					tecla_5: begin
						teste1 <= ~teste1;
					end
					tecla_8: begin
						teste1 <= ~teste1;
					end
					tecla_0: begin
						teste1 <= ~teste1;
					end
				endcase
				state <= coluna2;
			end
			coluna2: begin
				out <= 4'b1101;
				state_anterior <= coluna2;
				case(in)
					tecla_3: begin
						teste2 <= ~teste2;
						state <= debouncing;
					end
					tecla_6: begin
						teste2 <= ~teste2;
						state <= debouncing;
					end
					tecla_9: begin
						teste2 <= ~teste2;
						state <= debouncing;
					end
					tecla_esp: begin
						teste2 <= ~teste2;
						state <= debouncing;
					end
				endcase
				state <= coluna0;
			end
			debouncing: begin
				if(count < 18'd500000) begin
					count <= count_aux + 1;
					count_aux <= count;
				end
				else begin
					state <= state_anterior;
				end
			end
		endcase
	end

endmodule
