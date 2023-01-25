module instruction_decoder (
    
)

(
    // TODO: Figure out all required control unit output signals
    input logic [31 : 0] instruction,
    output logic [4 : 0] rs_one, rs_two, rd,
    output logic branch,
);

    // Opcode-based identifiers
    localparam r_type_instruction = 7'h33;
    localparam i_type_instruction = 7'h13;
    localparam s_type_instruction = 7'h23;
    localparam b_type_instruction = 7'h63;
    localparam lui_instruction = 7'h37;
    localparam auipc_instruction = 7'h17;
    localparam j_type_instruction = 7'h6F;


    // Result of decoding below
    logic [8 : 0] control_signals;

    // All of the control signals that need outputting
    logic reg_write, reg_dest, alu_source, branch, mem_write, mem_to_reg, jump, alu_opcode;

    always_comb begin
    
        // Opcode
        case (instruction[6 : 0])

            // Non-load and non-lui I-type instructions
            i_type_instruction: begin
        
            end

        endcase

        // Funct3
        case (instruction[14 : 12])
        endcase

        // Funct7
        case (instruction[31 : 25])
        endcase
    
    end

endmodule 