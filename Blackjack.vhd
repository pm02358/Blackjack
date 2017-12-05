LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.All;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY Blackjack IS

  PORT(RESET, CLOCK, COUNT   : IN  STD_LOGIC;
       SCOREV       : OUT STD_LOGIC);
		 
END Blackjack;


ARCHITECTURE behavior of Blackjack IS
  Type DECKOFCARDS_type is array(0 to 51) of UNSIGNED(3 downto 0);
  SIGNAL DECKOFCARDS : DECKOFCARDS_type;
  TYPE CSTATE_TYPE IS (CounterStart,Counting,Startover);
  SIGNAL Cstate : CSTATE_TYPE;
  TYPE STATE_TYPE IS (NewGame,Hit);
  SIGNAL state : STATE_TYPE;
  SIGNAL card  : UNSIGNED(3 downto 0); 
  SIGNAL Counter   : INTEGER range 0 to 51 := 51;
  SIGNAL card_number : INTEGER;
  SIGNAL SCORE: INTEGER range 0 to 21 := 21;
  SIGNAL DECK  : DECKOFCARDS_type := ("1011", "1011", "1011", "1011",
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
 PROCESS(RESET)
 BEGIN
   if (RESET= '0') THEN
    card_number <=  52;
	 
	ELSif (Counter= 0) THEN
      card_number <= 52;
		
   else
      card_number <= card_number - 1;
		
	end if;
 end Process;
--FSM that controls counter

Process(Cstate,card_number)
 BEGIN 
 card <= DECKOFCARDS(card_number);

  case Cstate is
  
    When CounterStart =>
	 if (card_number = 52) THEN
	   Cstate <=Counting;
		
	 else
	  Counter <= 0;
        end if;
		  
    When Counting =>
      Counter    <= 1;

      if (card_number = 0) then
        Cstate <= Startover;
		else
		  Cstate<= Counting;
      end if;

    When Startover =>
      Counter <= 0;
  end case;
end Process;
     --END Counter 
	  
    PROCESS(CLOCK, RESET)
      BEGIN
	--Current card in cycle

	  IF RESET='0' THEN  --Restart Game
		state <= NewGame;
	  ELSIF (CLOCK'EVENT AND CLOCK ='1') THEN
	  
	--Game States	 
		CASE state IS 

		  WHEN NewGame =>
		   score <= 0;
			state <= Hit;
		  
		  WHEN Hit =>
		  score <= score;
		    IF (score < 22) THEN
			    state <= Hit;
			 ELSIF (score > 22) THEN
			    state <= NewGame;
			 end if;
	   end case;
     end if;
	 end Process;

end behavior;

