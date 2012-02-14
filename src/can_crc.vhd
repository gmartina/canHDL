
-- ########################################################################
-- CRC Engine RTL Design 
-- Copyright (C) www.ElectronicDesignworks.com 
-- Source code generated by ElectronicDesignworks IP Generator (CRC).
-- Documentation can be downloaded from www.ElectronicDesignworks.com 
-- ******************************** 
--            License     
-- ******************************** 
-- This source file may be used and distributed freely provided that this
-- copyright notice, list of conditions and the following disclaimer is
-- not removed from the file.                    
-- Any derivative work should contain this copyright notice and associated disclaimer.                    
-- This source code file is provided "AS IS" AND WITHOUT ANY WARRANTY, 
-- without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
-- PARTICULAR PURPOSE.
-- ********************************
--           Specification 
-- ********************************
-- File Name       : CRC15_DATA1.vhd    
-- Description     : CRC Engine ENTITY 
-- clk           : Positive Edge 
-- Reset           : Active High
-- First Serial    : MSB 
-- Data Bus Width  : 1 bits 
-- Polynomial      : (0 3 4 7 8 10 14 15)                   
-- Date            : 16-May-2011  
-- Version         : 1.0        
-- ########################################################################
                    
LIBRARY IEEE ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_arith.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY crc_gen IS 
   PORT(           
           clk      : IN  STD_LOGIC; 
           reset      : IN  STD_LOGIC; 
           soc        : IN  STD_LOGIC; 
           crc_data_in : IN  STD_LOGIC; 
           data_valid : IN  STD_LOGIC; 
           eoc        : IN  STD_LOGIC; 
           crc_out        : OUT STD_LOGIC_VECTOR(14 DOWNTO 0); 
           crc_valid  : OUT STD_LOGIC 
       );
END crc_gen; 

ARCHITECTURE behave OF crc_gen IS 

 SIGNAL crc_r          : STD_LOGIC_VECTOR(14 DOWNTO 0);
 SIGNAL crc_c          : STD_LOGIC_VECTOR(14 DOWNTO 0);
 SIGNAL crc_i          : STD_LOGIC_VECTOR(14 DOWNTO 0);
 SIGNAL crc_const      : STD_LOGIC_VECTOR(14 DOWNTO 0) := "000000000000000";

BEGIN 

	      
crc_i    <= crc_const when soc = '1' else
            crc_r;

crc_c(0) <= crc_data_in XOR crc_i(14); 
crc_c(1) <= crc_i(0); 
crc_c(2) <= crc_i(1); 
crc_c(3) <= crc_data_in XOR crc_i(2) XOR crc_i(14); 
crc_c(4) <= crc_data_in XOR crc_i(3) XOR crc_i(14); 
crc_c(5) <= crc_i(4); 
crc_c(6) <= crc_i(5); 
crc_c(7) <= crc_data_in XOR crc_i(6) XOR crc_i(14); 
crc_c(8) <= crc_data_in XOR crc_i(7) XOR crc_i(14); 
crc_c(9) <= crc_i(8); 
crc_c(10) <= crc_data_in XOR crc_i(9) XOR crc_i(14); 
crc_c(11) <= crc_i(10); 
crc_c(12) <= crc_i(11); 
crc_c(13) <= crc_i(12); 
crc_c(14) <= crc_data_in XOR crc_i(13) XOR crc_i(14); 


crc_gen_process : PROCESS(clk, reset) 
BEGIN                                    
 IF(reset = '1') THEN  
    crc_r <= "000000000000000" ;
 ELSIF rising_edge(clk) THEN 
    IF(data_valid = '1') THEN 
         crc_r <= crc_c; 
    END IF; 
 END IF;    
END PROCESS crc_gen_process;      
    

crc_valid_gen : PROCESS(clk, reset) 
BEGIN                                    
 If(reset = '1') THEN 
     crc_valid <= '0'; 
 ELSIF( clk 'EVENT AND clk = '1') THEN 
    IF(data_valid = '1' AND eoc = '1') THEN 
        crc_valid <= '1'; 
    ELSE 
        crc_valid <= '0'; 
    END IF; 
 END IF;    
END PROCESS crc_valid_gen; 

crc_out <= crc_r; --might need to buffer this one more time

END behave;