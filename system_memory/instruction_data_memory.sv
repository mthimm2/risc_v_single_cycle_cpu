module instruction_data_memory (
    parameter num_thirty_two_bit_words = 128;
) (
    input logic clk, write_enable
    input logic word, half, single_byte,
    input logic address[$clog2(num_thirty_two_bit_words * 4) - 1 : 0],
    input logic [31 : 0] write_data
    output logic [31 : 0] read_data
);

    // TODO: How to handle lw, lhw, lb and read variants, with respect to address?

    // Byte-addressible memory
    logic [(num_thirty_two_bit_words * 4) - 1 : 0][7:0] instruction_data_memory;

    // Little-endian-based memory reads
    always_comb begin
    
        // LW
        if (word) begin
            
            // Get all four bytes out of memory in order
            read_data[7 : 0] = instruction_data_memory[address];
            read_data[15 : 8] = instruction_data_memory[address + 1];
            read_data[23 : 16] = instruction_data_memory[address + 2];
            read_data[31 : 24] = instruction_data_memory[address + 3];

        end

        // LH
        else if (half) begin

            // Higher two bytes are just zeros
            read_data[7 : 0] = instruction_data_memory[address];
            read_data[15 : 8] = instruction_data_memory[address + 1];
            read_data[31 : 16] = 16'h0000;

        end

        // LB
        else if (single_byte) begin

            // Higher three bytes are just zeros
            read_data[7 : 0] = instruction_data_memory[address];
            read_data[31 : 8] = 24'h000000;
            
        end

        // This should never happen. Just here to make the compiler happy
        else

    end

    // Little-endian-based memory writes
    always_ff @(posedge clk) begin
        if (write_enable) begin
            
            // SW
            if (word) begin
            
                // Write all four bytes to their sequential addresses
                instruction_data_memory[address] = write_data[7 : 0];
                instruction_data_memory[address + 1] = write_data[15 : 8];
                instruction_data_memory[address + 2] = write_data[23 : 16];
                instruction_data_memory[address + 3] = write_data[31 : 24];

            end

            // SH
            else if (half) begin

                instruction_data_memory[address] = write_data[7 : 0];
                instruction_data_memory[address + 1] = write_data[15 : 8];

            end

            // SB
            else if (single_byte) begin

                instruction_data_memory[address] = write_data[7 : 0];

            end

            // This should never happen. Just here to make the compiler happy
            else
                instruction_data_memory[address] = 8'h00;

        end
    end


endmodule 