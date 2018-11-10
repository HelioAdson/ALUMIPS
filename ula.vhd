library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.opcodes.all;

entity ula is 
	generic ( WSIZE : natural := 32 );
	port (
			opcode      		:in STD_logic_vector(4 downto 0);
			A,B         		:in STD_logic_vector((WSIZE-1) downto 0);
			Z						:out STD_logic_vector((WSIZE-1)downto 0);
			zero,overflow 		:out STD_logic);

end ula;

architecture ulaMIPS of ula is

SIGNAL soma,sub,z_proc : STD_logic_vector((WSIZE-1) downto 0);
BEGIN

soma <= std_logic_vector(signed(A) + signed(B));
sub  <= std_logic_vector(signed(A) - signed(B));


proc_ula: process (opcode,A,B,soma,sub,z_proc) is
variable contador : std_logic_vector((WSIZE -1) downto 0):= X"00000000";
begin 
	overflow <= '0';
	case (opcode) is
		when AND_MIPS =>
			z_proc <= A and B;
		when OR_MIPS =>
			z_proc <= A or B;
		when ADD_MIPS =>
			z_proc <= soma;
			overflow <= (A(31) xnor B(31)) and (A(31) xor soma(31));
		when ADDU_MIPS =>
			z_proc <= soma;
		when SUB_MIPS =>
			z_proc <= sub;
			overflow <= (B(31) and sub(31));
		when SUBU_MIPS =>
			z_proc <= sub;	
		when SLT_MIPS =>
			if (signed(A) < signed(B))
				then z_proc <= X"00000001";
				else z_proc <= X"00000000";
			end if;
		when SLTU_MIPS =>
			if (unsigned(A) < unsigned(B))
				then z_proc <= X"00000001";
				else z_proc <= X"00000000";
			end if;
		when NOR_MIPS =>
			z_proc <= A nor B;
		when XOR_MIPS =>
			z_proc <= A xor B;
		when SLL_MIPS =>
			z_proc <= std_logic_vector(shift_left(unsigned(B),to_integer(unsigned(A))));
		when SRL_MIPS =>
			z_proc <= std_logic_vector(shift_right(signed(B),to_integer(unsigned(A))));
		when SRA_MIPS =>
			z_proc <= std_logic_vector(rotate_right(unsigned(B),to_integer(unsigned(A))));
		when CLZ_MIPS =>
			contador := X"00000000";
			for i in 31 downto 0 loop
				if ((A(i)) = '0') then 
					contador := std_logic_vector(unsigned(contador) + X"0000001");
				else
				exit;
				end if;
			end loop;
			z_proc <= contador;
		when CLO_MIPS =>
			contador := X"00000000";
			for i in 31 downto 0 loop
				if ((A(i)) = '1') then 
					contador := std_logic_vector(unsigned(contador) + X"0000001");
				else
				exit;
				end if;
			end loop;
			z_proc <= contador;
		when others =>
		z_proc <= (others => '0');
	end case;
			if (z_proc = X"00000000") then 
				zero <= '1';
			else
				zero <= '0';
			end if;	
end process proc_ula;
Z <= z_proc;
end ulaMIPS;