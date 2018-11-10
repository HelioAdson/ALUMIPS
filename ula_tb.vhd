LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;    
use ieee.numeric_std.all;  
use work.opcodes.all;                          

ENTITY ula_tb IS 
generic ( WSIZE : natural := 32 );
END ula_tb; 

ARCHITECTURE ula_arch OF ula_tb IS 
-- signals                                               
SIGNAL opcode      		: STD_logic_vector(4 downto 0);
SIGNAL A,B         		: STD_logic_vector((WSIZE-1) downto 0);
SIGNAL Z						: STD_logic_vector((WSIZE-1)downto 0);
SIGNAL zero,overflow 	: STD_logic;

COMPONENT ula is 
	port (
			opcode      		:in STD_logic_vector(4 downto 0);
			A,B         		:in STD_logic_vector((WSIZE-1) downto 0);
			Z						:out STD_logic_vector((WSIZE-1)downto 0);
			zero,overflow 		:out STD_logic);
END COMPONENT;

BEGIN 
	i1 : ula
	PORT MAP (opcode => opcode, A => A,B => B,Z => Z, zero => zero,overflow => overflow);
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN       
	opcode <= AND_MIPS;	--and test
	A <= X"000000FF";
	B <= X"0000000F";
	wait for 10 ps; 

	opcode <= AND_MIPS;	--and test
	A <= X"FFFFFFFF";
	B <= X"00000000";
	wait for 10 ps;  	
	
	opcode <= OR_MIPS;	--or test
	A <= X"000000FF";
	B <= X"0000000F";
	wait for 10 ps; 
	
	opcode <= OR_MIPS;	--or test
	A <= X"00000000";
	B <= X"FFFFFFFF";
	wait for 10 ps; 
	
	opcode <= ADD_MIPS;	-- add positive test
	A <= X"000000CC";
	B <= X"00000033";
	wait for 10 ps;
	
	opcode <= ADD_MIPS;	-- add negative test
	A <= X"FFFFFFFF";
	B <= X"00000000";
	wait for 10 ps;
	
	opcode <= ADD_MIPS;	-- add zero(flag) test
	A <= X"FFFFFFFF";
	B <= X"00000001";
	wait for 10 ps;
	
	opcode <= ADD_MIPS;  -- add overflow test
	A <= X"6FFFFFFF";
	B <= X"7FFFFFFF";
	wait for 10 ps;
	
	opcode <= ADDU_MIPS;	-- addu positive test
	A <= X"000000CC";
	B <= X"00000033";
	wait for 10 ps;
	
	opcode <= ADDU_MIPS;	-- addu negative test
	A <= X"FFFFFFFF";
	B <= X"00000000";
	wait for 10 ps;
	
	opcode <= ADDU_MIPS;	-- addu zero(flag) test
	A <= X"FFFFFFFF";
	B <= X"00000001";
	wait for 10 ps;
	
	opcode <= ADDU_MIPS;  -- addu overflow test
	A <= X"6FFFFFFF";
	B <= X"7FFFFFFF";
	wait for 10 ps;
	
	opcode <= SUB_MIPS;	-- sub positive test
	A <= X"000000CC";
	B <= X"00000033";
	wait for 10 ps;
	
	opcode <= SUB_MIPS;	-- sub negative test
	A <= X"00000033";
	B <= X"000000CC";
	wait for 10 ps;
	
	opcode <= SUB_MIPS;	-- sub zero(flag) test
	A <= X"00000044";
	B <= X"00000044";
	wait for 10 ps;
	
	opcode <= SUB_MIPS;  -- sub overflow test
	A <= X"F6FFFFFF";
	B <= X"F7FFFFFF";
	wait for 10 ps;
	
	opcode <= SUBU_MIPS;	-- subu positive test
	A <= X"000000CC";
	B <= X"00000033";
	wait for 10 ps;
	
	opcode <= SUBU_MIPS;	-- subu negative test
	A <= X"00000033";
	B <= X"000000CC";
	wait for 10 ps;
	
	opcode <= SUBU_MIPS;	-- subu zero(flag) test
	A <= X"00000044";
	B <= X"00000044";
	wait for 10 ps;
	
	opcode <= SUBU_MIPS;  -- subu overflow test
	A <= X"F6FFFFFF";
	B <= X"F7FFFFFF";
	wait for 10 ps;

	opcode <= SLT_MIPS;  -- slt  greater test
	A <= X"000000CC";
	B <= X"00000033";
	wait for 10 ps;
	
	opcode <= SLT_MIPS;  -- slt  lesser test
	A <= X"0000FFFF";
	B <= X"000FFFFF";
	wait for 10 ps;
	
	opcode <= SLTU_MIPS;  -- sltu greater test
	A <= X"F00000CC";
	B <= X"F0000033";
	wait for 10 ps;

	opcode <= SLTU_MIPS;  -- stlu lesser test
	A <= X"F0000033";
	B <= X"F00000CC";
	wait for 10 ps;

	opcode <= NOR_MIPS;  -- nor test
	A <= X"0000FFFF";
	B <= X"000000FF";
	wait for 10 ps;
	
	opcode <= NOR_MIPS;  -- nor test
	A <= X"00000000";
	B <= X"00000000";
	wait for 10 ps;
	
	opcode <= XOR_MIPS;  -- xor test
	A <= X"00000000";
	B <= X"FFFFFFFF";
	wait for 10 ps;

	opcode <= XOR_MIPS;  -- xor test
	A <= X"0F0F0F0F";
	B <= X"0F0F0F0F";
	wait for 10 ps;
	
	opcode <= SLL_MIPS;  -- sll test
	A <= X"00000001";
	B <= X"0000000F";
	wait for 10 ps;
	
	opcode <= SLL_MIPS;  -- sll test
	A <= X"00000001";
	B <= X"F0000000";
	wait for 10 ps;
	
	opcode <= SRL_MIPS;  -- srl test
	A <= X"00000002";
	B <= X"00000F00";
	wait for 10 ps;
	
	opcode <= SRL_MIPS;  -- srl test
	A <= X"00000001";
	B <= X"F0000000";
	wait for 10 ps;
	
	opcode <= SRA_MIPS;  -- sra test
	A <= X"00000002";
	B <= X"00000F00";
	wait for 10 ps;
	
	opcode <= SRA_MIPS;  -- sra test
	A <= X"00000002";
	B <= X"F0000000";
	wait for 10 ps;
	
	opcode <= CLZ_MIPS;  -- clz test
	A <= X"10000000";
	wait for 10 ps;
	
	opcode <= CLZ_MIPS;  -- clz zero test
	A <= X"F0000000";
	wait for 10 ps;
	
	opcode <= CLO_MIPS;  -- clo test
	A <= X"F0000000";
	wait for 10 ps;
	
	opcode <= CLO_MIPS;  -- clo zero test
	A <= X"00000000";
	wait for 10 ps;
	
END PROCESS init;                                              
END ula_arch;