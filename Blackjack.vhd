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
  Type DECKOFCARDS is array(0 to 51) of STD_LOGIC_VECTOR(3 downto 0);
  TYPE STATE_TYPE IS (NewGame,Hit,Bust,CounterStart,Counting,Startover);
  SIGNAL state : STATE_TYPE;
  SIGNAL card  :  STD_LOGIC_VECTOR;
  SIGNAL Counter   : INTEGER range 0 to 51 := 51;
  SIGNAL card_number : STD_LOGIC_VECTOR;
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
											
Begin
--Counter 
 Process(RESET,Counter)
 BEGIN
   if (RESET= '0') THEN
    state  <= Startover;
	 
	ELSif (Counter= 0) THEN
      card_number <= 52;
		
   else
      card_number <= card_number - 1;
		
	end if;
 end Process;
--FSM that controls counter

Process(state,card_number)
 BEGIN 
  state    <=CounterStart ;
  Counter     <= 1;

  case state is
  
    When CounterStart =>
	 if (card_number = 52) THEN
	   state <=Counting;
		
	 else
	  Counter <= 0;
        end if;
		  
    When Counting =>
      Counter    <= 1;

      if (card_number = 0) then
        state   <= Startover;
		else
		  state<= Counting;
      end if;

    When Startover =>
      Counter <= 0;
 
  end case;
end Process;
     --END Counter 
	  
    PROCESS(CLOCK, RESET)
      BEGIN
	--Current card in cycle
		card <= DECKOFCARDS(card_number);
	  IF RESET='0' THEN  --Restart Game
		state <= NewGame;
	  ELSIF (CLOCK'EVENT AND CLOCK ='1') THEN
	  
	--Game States	 
		CASE state IS 

		  WHEN NewGame =>
		   score <= 0;
			state <= Hit;
		  
		  WHEN Hit =>
		  score <= score + card;
		    IF (score < 22) THEN
			    state <= Hit;
			 ELSIF (score > 22) THEN
			    state <= NewGame;
			 end if;
	   end case;
     end if;
	 end Process;
	end behavior;

