//Str to guess 
String str;

HashMap<Character,Boolean> hm; //for making keyboard
HashMap<Character,Boolean> hm_word;//for making an array of letters in word

boolean gameWon,abondonGame;//to check if gameWon or game is abondoned

int timer,m,timesreset;//to reset the game

int wrongGuess;//to check the wrong guesses

int timesWon,timesLost;//to check the score

String wrongLetter;//to show letters that has been guessed wrong

//to get words from word.txt
String[] words;//words that have capital letters
String[] wordsfromDict;//words with all lower case

void setup()
{
  size(800,600);
  
  textSize(30);
  
  //to have random words from txt
  words=loadStrings("words.txt");
  wordsfromDict=clean(words);
  str=wordsfromDict[int(random(0,wordsfromDict.length))];
  println(str);//words that are chose are randomly print on screen to check
  
  //set 5sec timer
  m=0;
  timer=0;
  
  //check wrong guess
  wrongGuess=0;
  wrongLetter="";
  
  //check player won or loss
  gameWon=false;
  
  //if players abondone game
  abondonGame=false;
  
  hm=new HashMap<>(); 
  hm_word=new HashMap<>();

  for(int i=0;i<str.length();i++)
  {
    hm_word.put(str.charAt(i),false);
  }
  for(char cS='a';cS<='z';cS++)
  {
    hm.put(cS,false);
  }
}
void draw()
{
 background(0);
 drawAlphabet();
 drawWord();
 drawWrongGuess();
 drawGameFinish();
 if(abondonGame)
 {
   background(0);
   text("Game Abandon",width/2,height/2);
   text("Press mouse to resume",width/2,height/2+50);
 }
 if(mousePressed)//to resume the game if mouse is pressed
 {
  abondonGame=false;
 }
  
  //to display score
  fill(255);
  textAlign(CENTER);
  text("Won : "+timesWon/500,width-100,50);
  text("Lost : "+timesLost/500,width-100,100);
  text("Score : "+(timesWon-timesLost)/500,width-100,150);

  text("Wrong Guesses:"+wrongLetter,width-160,200);
  drawhangMan();
}

//to check which key s pressed and act accordingly
void keyPressed()
{
  if(hm_word.containsKey(key))//to change boolean if its there
  hm_word.put(key,true);
  else
  {
   if(hm.containsKey(key))//to increment wrong guesses if word doen't contain letter
   wrongGuess++;
   wrongLetter+=" "+key;
  }
  if(key=='%')//to abondon game
  {
   abondonGame=true;
  }
  
  if(hm.containsKey(key))//to turn keypad yellow if the letter is already been guessed
  hm.put(key,true);
}

//to make keypad
void drawAlphabet()
{
  float x = 50;
  float y = 50;
  float boxSize = 40;
  
  for (char c = 'a'; c <= 'z'; c++) 
  {
    // Check if the letter has been guessed
    boolean guessed = hm.get(c);
    
    // Draw a box around the letter based on the guessed status
    stroke(0);
    if (guessed) 
    fill(255, 255, 0);  // Yellow color for guessed letters
    else 
    fill(255,0,0);  // No fill for unguessed letters
    strokeWeight(3);
    stroke(255);
    rect(x, y, boxSize, boxSize,10);
    
    // Draw the letter inside the box
    fill(0);
    textSize(30);
    textAlign(CENTER,CENTER);
    text(c, x + boxSize / 2, y + boxSize / 2);
    
    // Move to the next position
    x += boxSize + 10;
    // Move to the next row after every 6 characters for better readability
    if ((c-'a'+1) % 6 == 0) 
    {
      x = 50;
      y += boxSize + 10;
    }
  }
}

//to draw each letter if guessed correct
void drawWord()
{
  int check=0;
  for(int i=0;i<str.length();i++)
  {
    boolean guessedletter = hm_word.get(str.charAt(i));//to check if letter is guessed
    fill(255);
    text("   __   ",i*40+20,400);
    if(guessedletter)
    {
     text(str.charAt(i),i*40+20,400);
     check++;//to check the number of letter guessed in word
    }
  }
  if(check==str.length())//if checked number of letter becomes equal to length of word game won
  {
   gameWon=true;
  }
}

//to reset the game
void reset()
{
   hm=new HashMap<>(); 
   hm_word=new HashMap<>();
   str=wordsfromDict[int(random(0,wordsfromDict.length))];
   println(str);// to check the game
   
   //making all character to false to reset it
   for(int i=0;i<str.length();i++)
   hm_word.put(str.charAt(i),false);
  
   for(char cS='a';cS<='z';cS++)
   hm.put(cS,false);
    
   gameWon=false;
   wrongGuess=0;
   wrongLetter="";
}

//to draw circles if guessed wrong
void drawWrongGuess()
{
 fill(255,0,0);
 if(wrongGuess<=5)//if guessed wrong letters is less than 5 else you loose
 for(int i=0;i<wrongGuess;i++)
 {
  circle(i*30+20,height*3/4,20);
 }
}

//to display message if game is finished
void drawGameFinish()
{
  if(gameWon || wrongGuess>=5)
  {
    //to reset the game we need timers to count
    m++;
    timer=0;
    
    background(0);//to remove the game
    
    if(gameWon)//display hooray and number of times won increment
    {
    // Display "Hooray!" when the game is won
     fill(0, 255, 0);  // Green color for the winning message
     text("HOORAY!!!", width / 2, height / 2);
     timesWon++;
     text("You Won +1",width/2,height/2+50);//to give score
    }
    else//if you lose times Lost inceases and will display Sorry
    {
     fill(255,255,0);
     text("Sorry!!!", width / 2, height/2);
     timesLost++;
     text("You Lost -1",width/2,height/2+50);//to give score
    }
    if(m-timer>=5*100+timesreset*500)
    {
     timesreset++;//to count how many times the game has been reset
     reset();
     timer=m;
    }
   int timetoWait=(m-timer)/100;//to display timer you have to wait to reset the game
   text("Wait for 5sec: "+(5-timetoWait+timesreset*5),width/2,height/2+100);
   
   //to display the correct word after you won or loose
   fill(255);
   textAlign(LEFT);
   text("word : "+str,10,height*5/6);
  } 
}

//to clean the dictionary and to make letters to lower case
String[] clean(String[] data)
{
  String one = String.join(" ",data);
  one = one.toLowerCase();//to make all words to lower case
  String[] datout = one.split(" ",15000);
  return datout;
}

//to draw hangMan
void drawhangMan()
{
  noFill();
  strokeWeight(4);
  stroke(255);
  if(wrongGuess>=1)//draw face when gueesed one wrong letter
  circle(width-100,height/2,50);
  
  if(wrongGuess>=2)//draw body
  line(width-100,height/2+25,width-100,height/2+125);
  
  if(wrongGuess>=3)//draw hands
  {
   line(width-100,height/2+75,width-175,height/2);
   line(width-100,height/2+75,width-25,height/2);
  }
  
  if(wrongGuess>=4)//draw legs
  {
   line(width-100,height/2+125,width-150,height/2+200);
   line(width-100,height/2+125,width-50,height/2+200);  
  }
  
  if(wrongGuess>=5)//draw a jail
  {
   stroke(255,0,0);
   line(width-175,height/2-25,width-25,height/2+200);
   line(width-25,height/2-25,width-175,height/2+200);  
   rect(width-180,height/2-30,160,230);
  }
}
