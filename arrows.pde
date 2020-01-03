//Justin Lu
//1/1/19
//A game of directionality, memory, and speed with arrows

//DRAFT AS OF JANUARY 13TH, 2019

int dir = 0, colourArrow, size;  //dir is the direction the arrow is facing,   colourArrow is to randomize the colour of the arrow,   size is used to randomize the size of the arrow
int answer = 0, response = 0;  //answer is the actual answer, and compares to the user's input, response
int prevDir = 0, prevColour = 0;  //prevDir and prevColour are to avoid printing an arrow twice, 
int lives = 3, score = 0;  //lives is to keep track of the user's lives,  score is to keep track of user's score

float arrowX, arrowY;  //arrowX and arrowY are to randomize the position of the arrow a bit

boolean exit = false, nextPhase = false, secondPhase = false;  //exit is to leave the program, nextPhase is so you can move on from the splash screen, and secondPhase is so you can move on from instructions
boolean incDown = false, assignment = true;  //Whether or not the gradient shoudl go up or down  
boolean pause = false;  //To pause the program
char mode = '0';  //The mode you choose to play at the beginning, and is a char in case the user enters "any other key"

PShape arrowW, arrowB, arrowG;  //The different arrows, one for each colour option
PFont fontTitle, fontText;  //The font I decided to use for large text, then smaller texts
float k = 0, j = 0.1, l = 1;  //k is to increase the amount of the gradient of the splash screen circle,   j will increase the size of the splash screen arrow, and l will keep track of arrow direction

//Uses exit(), from the Processing site, as well as delay(), from MCPT




//Displays game title
void title() {
  fill(225, 220, 222);
  textSize(40);
  
  textFont(fontTitle);
  text("QUICK!", 330, 100);
  quad(325, 115, 480, 105, 483, 107, 322, 130);
  quad(322, 130, 300, 130, 300, 90, 328, 115);
  quad(322, 130, 300, 130, 365, 155, 328, 118);
}







//Gradient that will change over time
void gradient() { 
  noStroke();
  for (int i = 1200; i >= 0; i-= 10) {  //Draws gradient once
    fill(15 + k, 50 + k, 75 + k);
    ellipse(width/2, height/2 + 25, i, i*3/4);
    k+=0.5;
  }

  if (incDown == true) {  //Whether or not to increase overall brightness or decrease
    k -= 61;
    if (k == 0) {  //If it is too dark, start to get brighter
      incDown = false;
    }
  } 
  else {
    k -= 59;
    if (k >= 28) {  //If it is too bright, start to get darker
      incDown = true;
    }
  }
}





//Display a waiting animation/splash screen
void splashScreen() {
  gradient();

  if (j <= 10) {
    pushMatrix();  //Set plane
    translate(400, 250);
    rotate(l);
    scale(j);
    
    if (colourArrow == 1) {  //Determine colour of arrow
      shape(arrowW, 0, 0);
    } else if (colourArrow == 2) {
      shape(arrowB, 0, 0);
    } else {
      shape(arrowG, 0, 0);
    }

    popMatrix();
    l += 0.25;  //Increment arrow size and rotation
    j += (j+ 0.1) * (j/5);
  } 
  else {  //Randomize colour
    colourArrow = int (random(3)+1);
    j = 0.8;
  }
  if (l >= 360) {  //A 360 turn is equal to not turning, and to prevent l from reaching max int value
    l -= 360;
  }

  title();
  textSize(15);
  text("Click anywhere to continue", 320, 320);
}









//Instructions
void instructions() {
  background(15, 50, 75);
  gradient();
  title();
  
  textFont(fontTitle);
  textSize(40);  //Outputs instructions
  text("ARROWS WILL APPEAR ON SCREEN\n\n", 120, 210);

  textFont(fontText);
  textSize(15);
  text("If it's WHITE, hit the OPPOSITE ARROW key\nIf it’s BLACK, hit the CORRESPONDING ARROW key\nand if it's GREY, hit the KEY 90° CLOCKWISE.", 180, 250);
  text("Round ends once you MISCLICK THREE TIMES (EXCEPT IN ZEN)\nYou also will lose a life if you HOLD THE KEY for LONGER THAN\nONE SECOND. Each correct arrow is worth 10 POINTS.", 180, 325);
  text("EASY: ONLY WHITE\nMEDIUM: WHITE & BLACK\nHARD: WHITE, BLACK, AND GREY\nZEN: ALL, BUT IT’S INFINITE", 180, 410);
  
  textFont(fontTitle);
  textSize(16);
  text("Click anywhere to continue", 470, 470);
}





//Main menu with game options
void mainMenu() {
  fill(255);
  textFont(fontTitle);
  textSize(22);    //Outputs game options
  text("Please enter:", 265, 210);
  textSize(16);
  text("1)    for EASY mode", 320, 250);
  text("2)    for MEDIUM mode", 320, 280);
  text("3)    for HARD mode", 320, 310);
  text("4)    for ZEN mode", 320, 340);
  text("5)    for INSTRUCTIONS", 320, 370);
  textSize(20);
  text("ANY OTHER KEY  to EXIT", 320, 410);
}



//Get which mode they enter, or if they want to leave
void getMode() {
  background(15, 50, 75);
  gradient();
  title();
  
  if (keyPressed) {  //If a keyboard key is pressed, checks what key/mode is pressed
    if (key == '1') {       //Easy Mode  (White, opposite)
      mode = '1';
    } 
    else if (key == '2') {  //Medium Mode  (White, opposite, Black, corresponding)
      mode = '2';
    } 
    else if (key == '3') {  //Hard Mode  (White, opposite, Black, corresponding, Grey, 90 clockwise)
      mode = '3';
    } 
    else if (key == '4') {  //Zen Mode  (Infinite lives)
      mode = '4';
    } 
    else if (key == '5') {  //Instructions
      mode = '5';
      secondPhase = false;
    } 
    else {                  //Exit
      exit = true;
    }
  } 
  else if (pause == false) {  //If the mouse was clicked, see if the mouse is clicking an option
    if (mouseX > 315 && mouseX < 440 && mouseY > 230 && mouseY <259) {  //Easy Mode  (White, opposite)
      fill(255, 30);
      rect(315, 230, 445, 259);
      if (mousePressed){
        mode = '1';
      }
    } 
    else if (mouseX > 315 && mouseX < 450 && mouseY > 260 && mouseY <289) {  //Medium Mode  (White, opposite, Black, corresponding)
      fill(255, 30);
      rect(315, 260, 467, 289);
      if (mousePressed){
        mode = '2';
      }
    } 
    else if (mouseX > 315 && mouseX < 440 && mouseY > 290 && mouseY <319) {  //Hard Mode  (White, opposite, Black, corresponding, Grey, 90 clockwise)
      fill(255, 30);
      rect(315, 290, 450, 319);
      if (mousePressed){
        mode = '3';
      }
    } 
    if (mouseX > 315 && mouseX < 440 && mouseY > 320 && mouseY <349) {  //Zen Mode  (Infinite lives)
      fill(255, 30);
      rect(315, 320, 440, 349);
      if (mousePressed){
        mode = '4';
      }
    } 
    if (mouseX > 315 && mouseX < 470 && mouseY > 350 && mouseY <385) {  //Instructions
      fill(255, 30);
      rect(315, 350, 470, 385);
      if (mousePressed){
        mode = '5';
      }
      secondPhase = false;
    }
    if (mouseX > 310 && mouseX < 530 && mouseY > 386 && mouseY < 420) {  //Exit
      fill(255, 30);
      rect(310, 386, 530, 420);
      if (mousePressed){
        mode = 'q';
        exit = true;
        delay(50);
      }
    } 
  }
}




//Get keyboard arrow input
void userInput() {  //Receives and interprets keyboard arrows and turns into an integer
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP) {
        response = 1;
      } 
      else if (keyCode == RIGHT) {
        response = 91;
      } 
      else if (keyCode == DOWN) {
        response = 181;
      } 
      else if (keyCode == LEFT) {
        response = 271;
      } 
    } 
    else if (key == 'q' || key == 'Q' || pause == true) {  //In case the user wants to quit
      pause = true;
    }
  }
}








//Update and print score
void score() {
  if (answer == response && pause != true) {  //If it was the right answer, increase score randomly by 10
    score += 10;
  }
  else if (answer != response && response != 0 && answer != 0 && keyPressed && key == CODED) {  //If it was wrong, take off a life
      lives--;
      response = 0;
      key = 0;
      delay(100);
  }
  if (lives <= 0 && mode != '4') {  //If the user has no more lives
    pause = true;
  }
  textFont(fontTitle);
  textSize(18);
  text("SCORE: " + score, 50, 50);
}










//Figure out what type of arrow to output, the colour, direction, placement, and to update score
void processing() {
  if (mode == '5') {  //If the user wants to see instructions
      if (!mousePressed && secondPhase == false) {
        instructions();
      } 
      else {
        secondPhase = true;
        mode = '0';
        gradient();
        title();
        mainMenu();
      }
  }
  
  
  else if (mode >= '1' && mode <= '4') {  //If they chose a game mode
    if (dir == 0 && assignment == true) {  //If variables havent been assigned
      dir = int (random(4) + 1);
      arrowX = random(350) + 240;          //Randomize postion of arrow
      arrowY = random(200) + 135;
      size = int(random(3, 11));
    
      
      
      
      if (arrowX >= 250 && arrowX <= 550 && arrowY <= 200) {  //To avoid arrows going over the title
        arrowY += 100;
      }


      if (dir == 1) {                       //Convert position from 1-4 (imagine as a clock, the four N,E,S,W  
        dir = 271;
      } 
      else if (dir == 2) {
        dir = 1;
      } 
      else if (dir == 3) {
        dir = 91;
      } 
      else if (dir == 4) {
        dir = 181;
      }


      if (mode == '1') {  //Depending on the mode they chose, randomizes the colour      (Easy)
        colourArrow = 1;
      } 
      else if (mode == '2' && colourArrow == 0) {  //  (Medium)
        colourArrow = int (random(2) + 1);
      } 
      else if ( (mode == '3' && colourArrow == 0) || (mode == '4' && colourArrow == 0) ) {  //  (Hard)
        colourArrow = int (random(3) + 1);
      }


      if (colourArrow == 1) {  //White
          answer = dir;
          if (answer > 271) {
            answer -= 360;
          }
      } 
      else if (colourArrow == 2) {   //Black
          answer = dir - 180;
          if (answer < 1) {
            answer += 360;
          }
      } 
      else if (colourArrow == 3) {   //Grey
          answer = dir - 90;
          if (answer < 1) {
            answer += 360;
          }
      }
      assignment = false;  //Assignment over, all variables have been reset
    }


    
    if (response == 0) {  //If no response has been given, check again
      userInput();
    }
    
    //If the answer was right
    if ((answer == response && pause == false && answer != 0 && response != 0) || (prevColour == colourArrow && prevDir == dir)) {
      score();
      colourArrow = 0;    //Reset variables
      prevDir = dir;  
      prevColour = colourArrow;
      dir = 0;  
      answer = 0;
      response = 0;
      assignment = true;
      key = 0;
    }
    
    if(dir != 0 && assignment == false && (prevColour != colourArrow || prevDir != dir)){        //As long as all variables have been reset
      display();
      score();
    }


    if (pause == true) {  //If game over (all lives used) or the user pressed "q" to quit
        if (lives <= 0 && mode != '4') {
          over();  //If the reason they left is because of no lives, and the mode is not ZEN, go to over()
        } 
        else {
          reaffirmExit();  //If the reason they left is because they pressed "q", for menu/exit, go to reaffirmExit()
        }
    }
  }
}







//Displays the arrow
void display() { 
  pushMatrix();
  background(15, 50, 75);
  gradient();
  title();
  translate(arrowX, arrowY);  //Sets plane info
  scale(size/7.0);  

  if (mode == '1') {  //Easy mode (Only white)
    if (answer == 1) {  //If the answer is up
      rotate(dir + 0.57);
    } 
    else if (answer == 91) {  //If the answer is right
      rotate(dir + 0.121);
    } 
    else if (answer == 181) {  //If the answer is down
      rotate(dir - 0.35);
    } 
    else {  //Else if the answer is left
      rotate(dir - 0.83);
    }
    shape(arrowW, 0, 0);  //Output white arrow
  } 
  
  
  
  else if (mode == '2') {  //Medium mode  (White and Black)
    if (colourArrow == 1) {  //If the colour for the answer is white
      if (answer == 1) {  //If the answer is up
        rotate(dir + 0.57);
      } 
      else if (answer == 91) {  //If the answer is right
        rotate(dir + 0.121);
      } 
      else if (answer == 181) {  //If the answer is down
        rotate(dir - 0.35);
      } 
      else {  //Else if the answer is left
        rotate(dir - 0.83);
      }
      shape(arrowW, 0, 0);  //Output white arrow
    } 
    else if (colourArrow == 2) {  //If the colour for the answer is black
      if (answer == 1) {  //If the answer is up
        rotate(dir - 0.35);
      } 
      else if (answer == 91) {  //If the answer is right
        rotate(dir - 0.83);
      } 
      else if (answer == 181) {  //If the answer is down
        rotate(dir + 0.57);
      } 
      else {  //If the answer is left
        rotate(dir + 0.121);
      }
      shape(arrowB, 0, 0);  //Output black arrow
    }
  } 
  
  
  else if (mode == '3' || mode == '4') {  //Hard or Zen Mode  (White, Black, and Grey)
    if (colourArrow == 1) {  //If the colour for the answer is white
      if (answer == 1) {  //If the answer is up
        rotate(dir + 0.57);
      } 
      else if (answer == 91) {  //If the answer is right
        rotate(dir + 0.121);
      } 
      else if (answer == 181) {  //If the answer is down
        rotate(dir - 0.35);
      } 
      else {  //If the answer is left
        rotate(dir - 0.83);
      }
      shape(arrowW, 0, 0);
    } 
    else if (colourArrow == 2) {  //If the colour for the answer is black
      if (answer == 1) {  //If the answer is up
        rotate(dir - 0.35);
      } 
      else if (answer == 91) {  //If the answer is right
        rotate(dir - 0.83);
      } 
      else if (answer == 181) {  //If the answer is down
        rotate(dir + 0.57);
      } 
      else {  //If the answer is left
        rotate(dir + 0.121);
      }
      shape(arrowB, 0, 0);
    } 
    else if (colourArrow == 3) {  //If the colour for the answer is grey / gray
      if (answer == 1) {  //If the answer is up
        rotate(dir + 0.121);
      } 
      else if (answer == 91) {  //If the answer is right
        rotate(dir - 0.35);
      } 
      else if (answer == 181) {  //If the answer is down
        rotate(dir - 0.83);
      } 
      else {  //If the answer is left
        rotate(dir + 0.57);
      }
      shape(arrowG, 0, 0);  //Output white arrow
    }
  }
  popMatrix();  //Reset plane for next turn
}




//To display game over screen
void over() {
  fill(15, 50, 75, 80);
  rect(175, 330, 625, 180);  //Make the pop-up box
  
  textFont(fontTitle);
  fill(255, 255);  //Output the game over text
  textSize(40);
  text("GAME OVER", 310, 230);
  
  textSize(18);
  text("Your final score was " + score, 315, 260);  //Output the final score
  
  textSize(15);
  text("M for Main Menu, or click to leave", 310, 300);  
  noStroke();
  
  if (keyPressed) {
    delay(1);
    if (key == 'm' || key == 'M') {  //If they choose to return to main menu
      mode = '0';
      exit = false;
      delay(100);  //Buffer, as otherwise it may take key as "m" still
      
      gradient();  //Reset background
      title();
      mainMenu();
      
      
      colourArrow = 0;  
      prevDir = dir;    //Reset variables
      prevColour = colourArrow;
      dir = 0;  
      answer = 0;
      response = 0;
      assignment = true;
      
      lives = 3;
      score = 0;
      
      
      
      if (mode != 0) {  //If the user has chosen a mode, go to processing
        pause = false;
        processing();
      } 
      else {  //Otherwise, keep variables reset
        delay(20);
        key = '0';
        mode = '0';
        keyPressed = false;
      }
    } 
  }
  else if (mousePressed) {  //Otherwise if they click to leave
    pause = false;
    exit = true;    
    delay(60);
  }
}






//To confirm exit menu
void reaffirmExit() {
  fill(15, 50, 75, 80);  //Make pop-up box
  rect(175, 430, 625, 180);
  
  textFont(fontTitle);
  textSize(25);  //Output reaffirm exit text
  fill(255, 255);
  text("ARE YOU SURE YOU WANT TO LEAVE?", 210, 230);
  textSize(18);
  text("GAME DATA WILL NOT BE SAVED", 265, 270);
  textSize(15);
  text("X to Leave, M for Main Menu, or click to resume", 260, 340);
  noStroke();

  if (keyPressed) {
    delay(1);
    if (key == 'm' || key == 'M') {  //If they choose to return to main menu
      mode = '0';
      exit = false;
      delay(75);  //Buffer, as otherwise it may take key as m still
      
      gradient();  //Reset background
      title();
      mainMenu();
      
      
      colourArrow = 0;  
      prevDir = dir;      //Reset variables
      prevColour = colourArrow;
      dir = 0;  
      answer = 0;
      response = 0;
      assignment = true;
      
      lives = 3;
      score = 0;
      
      
      
      if (mode != 0) {  //If they has chosen a mode, go to processing
        pause = false;
        processing();
      } 
      else {  //Otherwise, keep variables reset
        delay(20);
        key = '0';
        mode = '0';
        keyPressed = false;
      }
    } 
    else if (key == 'x' || key == 'X') {  //Otherwise, if they pressed "x" to leave
      pause = false;
      exit =  true;
      mode = 0;
    }
  } 
  else if (mousePressed) {  //Otherwise, if they clicked to resume
    pause = false;
  }
}













//Output goodbye screen
void goodbye() {
  title();
  textFont(fontTitle);
  textSize(40);
  text("Thank you for playing!", 220, 250);
  
  textSize(20);
  text("Click anywhere to exit", 310, 285);
  
  textSize(18);
  text("A game of directions, colour, and memory through arrows", 190, 480);
  text("PROGRAMMED BY JUSTIN LU", 290, 450);
}



//Run background size, draw arrows, etc.
void setup() {
  size(800, 500);
  background(15, 50, 75);
  noStroke();
  rectMode(CORNERS);

  //Creates the white coloured arrow
  arrowW = createShape();
  arrowW.setFill(220);
  arrowW.beginShape();
  arrowW.vertex(40, 10);
  arrowW.vertex(-40, 10);
  arrowW.vertex(-40, -10);
  arrowW.vertex(40, -10);
  arrowW.vertex(40, -30);
  arrowW.vertex(70, 0);
  arrowW.vertex(40, 30);
  arrowW.endShape();

  //Creates the black coloured arrow
  arrowB = createShape();
  arrowB.setFill(0);
  arrowB.beginShape();
  arrowB.vertex(40, 10);
  arrowB.vertex(-40, 10);
  arrowB.vertex(-40, -10);
  arrowB.vertex(40, -10);
  arrowB.vertex(40, -30);
  arrowB.vertex(70, 0);
  arrowB.vertex(40, 30);
  arrowB.endShape();

  //Creates the grey coloured arrow
  arrowG = createShape();
  arrowG.setFill(150); //125
  arrowG.beginShape();
  arrowG.vertex(40, 10);
  arrowG.vertex(-40, 10);
  arrowG.vertex(-40, -10);
  arrowG.vertex(40, -10);
  arrowG.vertex(40, -30);
  arrowG.vertex(70, 0);
  arrowG.vertex(40, 30);
  arrowG.endShape();
  
  fontTitle = loadFont("AppleSDGothicNeo-Thin-48.vlw");  //Load fonts
  fontText = loadFont("SansSerif-48.vlw");
}





//This will run infinitely, as in a for loop for repetition, it will only update at the end
void draw() {
  if (nextPhase == false) {  //If the user hasn't moved on from the beginning splash screen
    splashScreen();
        if (mousePressed) {  //If the user clicked, move on from splash screen
          splashScreen();
          nextPhase = true;  //Has a variable, so that the program will FOREVER move on after the user clicked the first time, and not keep repeating the splash screen after they let go of mouse
          
          delay(100);  //Buffer, otheriwse the program would take the first click as the user's choice of game mode
        }
  } 
  
  
  else {  //If they're finished with the splash screen
        if (exit == false) {  //If the user doesn't want to exit
          if (mode == '0' && mode != '5') {  //If the user doesn't have a mode yet
            getMode();  //Get mode and display options
            mainMenu();
          } 
          else {  //If the user has a mode selected
            processing();  //Start the game
          }
        } 
        else {  //If the user wants to exit
          background(15, 50, 75);
          gradient();
          goodbye();
          if (mousePressed) {
            exit();  //If they click to leave, close the program
          }
        }
  }
}

//Original Processing file version of the game
