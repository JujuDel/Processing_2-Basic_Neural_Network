///////////////////////
//
// DISPLAYs
//
///////////////////////

void displayDFF(MyDFF neuralNetwork, int num) {
  fill(0);
  textFont(f,14);
  
  if (!trained) {
    text("N°???", 10, 15);
    text("Label: ?", 13*18, 15);
    
    neuralNetwork.blank();
    neuralNetwork.display(-1, -1);
    
    textFont(f,18);
    fill(0,0,255);
    text("Bob: I think that I still need to train myself...", 280, 280);
  } else {
    text("N°" + num, 10, 15);
    text("Label: " + testing_set[dataNum].label, 13*18, 15);
  
    int found = neuralNetwork.respond(testing_set[dataNum]);
    neuralNetwork.display(found, testing_set[dataNum].label);
    
    fill(0, 0, 255);
    textFont(f,16);
    text("Curr Error: " + nf((float)neuralNetwork._network.computeTotalError(testing_set[dataNum].label), 0, 4), 660, 14*18+20);
    
    textFont(f,18);
    if (found == testing_set[dataNum].label) {
      fill(0,200,0);
      text("Bob: Yes! I knew that it was a " + found + "!", 280, 280);
    } else {
      fill(255,0,0);
      text("Bob: Oh no... I thought that it was a " + found + "...", 280, 280);
    }
  }
}

void displayAccuracy(double accuracy) {
  fill(0, 0, 255);
  textFont(f,16);
  
  text("Accuracy: " + nf((float)accuracy, 0, 4), 74, 14*18+40);
}

void displayError(double error) {
  fill(0, 0, 255);
  textFont(f,16);
  
  text("Average Error: " + nf((float)error, 0, 3), 645, 14*18+40);
}

///////////////////////
//
// EVENTs
//
///////////////////////

// This method is called when a key is pressed
void keyPressed() {
  if (key == ' ')
  {
    // TRY ANOTHER DIGIT
    dataNum = int(random(testing_set.length));
  }
  else if (key == 'r' || key == 'R')
  {
    // RESET
    hiddens = new int[1];
    hiddens[0] = 49;
    
    trained = false;
    
    selectedHiddenLayer = 0;
  }
}
