module ContadorConTrigger(
    input wire clk,          
    output reg trigger, led2      
);


reg [6:0] contador1=0;        //60us=7500000 33 bits=68ms
parameter limitcount= 7'd20;
parameter limittrig = 7'd6; //10us--24us
always @(posedge clk)
 begin
 if (contador1<limitcount)
 begin
    contador1<=contador1+1;
    if (contador1 < limittrig) 
	begin
        trigger <= 1'b1;
        led2 <= 1'b1;
    end 
	else 
	begin
        trigger <= 1'b0;
    end
 end
else
begin
contador1<=0;
end
end
endmodule

module ContadorConEcho(
    input wire clk,           // Entrada de reloj
    input wire echo,          // Entrada de control (cuando echo=1, se incrementa el contador)
	input wire trigger,
    output reg [6:0] contador2=0, // Salida del contador de 32 bits
	output reg led3
);

always @(posedge clk) 
    begin
		if(echo==1)
			begin
				contador2=contador2+1; //Se va almacenando en un contador si el ultrasonido genera el echo
				led3<=1;
			end
		else if (trigger)
			begin 
				contador2=0;
			end
	end
endmodule

module ControlLed(
    input clk,
    input wire [6:0] contador2,
    output reg led1  
);
//assign  led1 = (contador2>108750000)?1'b1:1'b0;
parameter L1=6'd5; 
always @(posedge clk)  
	begin

		if (contador2<L1)
			begin
				led1 <= 1;  
			end
		else
			begin
				led1 <= 0;
			end
	end	
endmodule

module top(
  input clk,
  input echo,
  output trig,
  output led1,
  output led2,
  output led3
);
  wire [6:0] s0;
  // ContadorConTrigger
  ContadorConTrigger ContadorConTrigger_i0 (
    .clk( clk ),
    .trigger( trig ),
	.led2(led2)
  );
  // ContadorConEcho
  ContadorConEcho ContadorConEcho_i1 (
    .clk( clk ),
    .echo( echo ),
	.trigger( trig ),
    .contador2( s0 ),
	.led3( led3 )
  );
  // ControlLed
  ControlLed ControlLed_i2 (
    .clk( clk ),
    .contador2( s0 ),
    .led1( led1 )
  );
endmodule
		
