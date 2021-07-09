module tb;

    // Inputs
    reg clk;
    reg wr_en;
    reg [7:0] data_in;
    reg [3:0] addr_in_0;
    reg [3:0] addr_in_1;
    reg port_en_0;
    reg port_en_1;

    // Outputs
    wire [7:0] data_out_0;
    wire [7:0] data_out_1;
    
    integer i;

    // Instantiate the Unit Under Test (UUT)
    dual_port_ram uut (
        .clk(clk), 
        .wr_en(wr_en), 
        .data_in(data_in), 
        .addr_in_0(addr_in_0), 
        .addr_in_1(addr_in_1), 
        .port_en_0(port_en_0), 
        .port_en_1(port_en_1), 
        .data_out_0(data_out_0), 
        .data_out_1(data_out_1)
    );
    
    always
        #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 1;
        addr_in_1 = 0;
        port_en_0 = 0;
        port_en_1 = 0;
        wr_en = 0;
        data_in = 0;
        addr_in_0 = 0;  
        #20;
        //Write all the locations of RAM
        port_en_0 = 1;  
        wr_en = 1;
      for(i=1; i <= 16; i = i + 1) begin
            data_in = i;
            addr_in_0 = i-1;
            #10;
        end
        wr_en = 0;
        port_en_0 = 0;  
        //Read from port 1, all the locations of RAM.
        port_en_1 = 1;  
        for(i=1; i <= 16; i = i + 1) begin
            addr_in_1 = i-1;
            #10;
        end
        port_en_1 = 0;
    end
      
endmodule
