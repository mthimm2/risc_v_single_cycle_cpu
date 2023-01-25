module register_file (
    parameter num_registers = 32,
    parameter register_size = 32
) (
    input logic clk,
    input logic [$clog2(num_registers) - 1 : 0] rs, 
    input logic [$clog2(num_registers) - 1 : 0] rt, 
    input logic [$clog2(num_registers) - 1 : 0] rd,
    input logic write_enable,
    input logic [register_size - 1 : 0] write_data,
    output logic [register_size - 1 : 0] read_data_rs, read_data_rt
)


    // The array of registers
    // Not bit addressible, indicated by placing size after variable name
    logic [num_registers - 1 : 0] register_file[register_size - 1 : 0];


    // Register handling
    always_comb begin
    
        // RS handling and zero register
        if (rs == 0)
            read_data_rs = 0;
        else
            read_data_rs = register_file[rs];

        // RT handling and zero register
        if (rt == 0)
            read_data_rt = 0;
        else
            read_data_rt = register_file[rt];

    end

    // Write handling
    always_ff @(posedge clk)
        if (write_enable)
            register_file[rd] = write_data;

endmodule