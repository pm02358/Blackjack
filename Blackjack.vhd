LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
USE  ieee.NUMERIC_STD.all;

ENTITY Blackjack IS

  PORT(RESET, CLOCK   : IN  STD_LOGIC;
       SCORE       : OUT STD_LOGIC);
		 
END Blackjack;


ARCHITECTURE behavior of Blackjack IS
  Type DECKOFCARDS is array(0 to 51) of std_logic_vector(3 downto 0);
  TYPE STATE_TYPE IS (NewGame,Hit,Bust);
  SIGNAL state : STATE_TYPE;
  SIGNAL card  : std_logic_vector(3 downto 0);
  SIGNAL card_number : std_logic_vector(3 downto 0);
  SIGNAL DECK  : DECKOFCARDS := ("1011", "1011", "1011", "1011",
                                 "1010", "1010", "0111", "0100",
                                 "1010", "1010", "0111", "0100",
                                 "1010", "1010", "0111", "0100",
                                 "1010", "1010", "0111", "0100",
                                 "1010", "1001", "0110", "0011",
                                 "1010", "1001", "0110", "0011",
                                 "1010", "1001", "0110", "0011",
                                 "1010", "1001", "0110", "0011",
                                 "1010", "1000", "0101", "0010",
                                 "1010", "1000", "0101", "0010",
                                 "1010", "1000", "0101", "0010",
                                 "1010", "1000", "0101", "0010");

  BEGIN 
    PROCESS(CLOCK, RESET)
      BEGIN
	--Cycle Through Deck
		card <= DECKOFCARDS(card_number);
		card_number <= cardnumber +1;
      		
	--Restart
		 IF RESET='0' THEN
		    state <= NewGame;
			 ELSIF (CLOCK'EVENT AND CLOCK ='1') THEN
 --Start of FSM
		 CASE state IS 
		 
		  WHEN NewGame =>
		   score <= 0;
			state <= Hit;
		  
		  WHEN Hit =>
		  score <= score+card;
		    IF score < 22 THEN
			    state <= Hit;
			ELSIF score > 22 THEN
			    state <= NewGame;
			 end if;
	   end case;
     end if;
	 end process;
	end behavior;
