library ieee; 
use ieee.std_logic_1164.all; 
package opcodes is 

CONSTANT AND_MIPS : std_logic_vector(4 downto 0) := "00000";
CONSTANT OR_MIPS : std_logic_vector(4 downto 0) := "00001";
CONSTANT ADD_MIPS : std_logic_vector(4 downto 0) := "00010";
CONSTANT ADDU_MIPS : std_logic_vector(4 downto 0) := "00011";
CONSTANT SUB_MIPS : std_logic_vector(4 downto 0) := "00100";
CONSTANT SUBU_MIPS : std_logic_vector(4 downto 0) := "00101";
CONSTANT SLT_MIPS : std_logic_vector(4 downto 0) := "00110";
CONSTANT SLTU_MIPS : std_logic_vector(4 downto 0) := "00111";
CONSTANT NOR_MIPS : std_logic_vector(4 downto 0) := "01000";
CONSTANT XOR_MIPS : std_logic_vector(4 downto 0) := "01001";
CONSTANT SLL_MIPS : std_logic_vector(4 downto 0) := "01010";
CONSTANT SRL_MIPS : std_logic_vector(4 downto 0) := "01011";
CONSTANT SRA_MIPS : std_logic_vector(4 downto 0) := "01100";
CONSTANT CLZ_MIPS : std_logic_vector(4 downto 0) := "01101";
CONSTANT CLO_MIPS : std_logic_vector(4 downto 0) := "01110";

end opcodes;