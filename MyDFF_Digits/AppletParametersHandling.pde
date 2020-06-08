class AppletParametersHandling extends PApplet {
  private boolean isMouseInHiddenLayer, isMouseInNeuron, isMouseInRateWeight, isMouseInRateBias, isMouseInButtons; 
  
  public void settings() {
    size(500, 170);
    
    isMouseInHiddenLayer = false;
    isMouseInNeuron      = false;
    isMouseInRateWeight  = false;
    isMouseInRateBias    = false;
    isMouseInButtons     = false;
  }
  
  public void draw() {
    background(255);
    
    // Just to change the cursor
    if (isMouseInClickableZone())
      cursor(HAND);
    else
      cursor(ARROW);
      
    displayHiddenLayerZone();
    displayLearningRateZone();
    displayButtons();
  }
  
  boolean isMouseInClickableZone() {
    return isMouseInHiddenLayerClickableZone() ||
           isMouseInNeuronClickableZone()      ||
           isMouseInRateWeightClickableZone()  ||
           isMouseInRateBiasClickableZone()    ||
           isMouseInButtonsZone();
  }
  
  boolean isMouseInHiddenLayerClickableZone() {
    isMouseInHiddenLayer = (mouseX > 52 && mouseX < 52 + 20 && mouseY > 50 && mouseY < 50 + 20) || // + hidden
                           (mouseX > 82 && mouseX < 82 + 20 && mouseY > 55 && mouseY < 55 + 10) || // - hidden
                           (mouseX > 69 && mouseX < 69 + 16 && mouseY > 75 && mouseY < 75 + 16);   // rect hidden
    return isMouseInHiddenLayer;
  }
  
  boolean isMouseInNeuronClickableZone() {
    isMouseInNeuron = (mouseX > 67 && mouseX < 67 + 20 && mouseY > 130 && mouseY < 130 + 20) || // + neuron
                      (mouseX > 97 && mouseX < 97 + 20 && mouseY > 135 && mouseY < 135 + 10);   // - neuron
    return isMouseInNeuron;
  }
  
  boolean isMouseInRateWeightClickableZone() {
    isMouseInRateWeight = (mouseX > 272 && mouseX < 272 + 20 && mouseY > 50     && mouseY < 50 + 20) || // + weight
                          (mouseX > 302 && mouseX < 302 + 20 && mouseY > 55     && mouseY < 55 + 10) || // - weight
                          (mouseX > 330 && mouseX < 330 + 20 && mouseY > 50     && mouseY < 50 + 20) || // x weight
                          (mouseX > 357 && mouseX < 357 + 20 && mouseY > 50 - 5 && mouseY < 70 + 5);    // % weight
    return isMouseInRateWeight;
  }
  
  boolean isMouseInRateBiasClickableZone() {
    isMouseInRateBias = (mouseX > 272 && mouseX < 272 + 20 && mouseY > 130     && mouseY < 130 + 20) || // + bias
                        (mouseX > 302 && mouseX < 302 + 20 && mouseY > 135     && mouseY < 135 + 10) || // - bias
                        (mouseX > 330 && mouseX < 330 + 20 && mouseY > 130     && mouseY < 130 + 20) || // x bias
                        (mouseX > 357 && mouseX < 357 + 20 && mouseY > 130 - 5 && mouseY < 150 + 5);    // % bias
    return isMouseInRateBias;
  }
  
  boolean isMouseInButtonsZone() {
    isMouseInButtons = (mouseX > 415 && mouseX < 415 + 75) &&
                        ((mouseY > 25 && mouseY < 25 + 30) || // TRAIN
                         (mouseX > 60 && mouseX < 60 + 30) || // IMAGE
                         (mouseX > 95 && mouseX < 95 + 30));  // RESET
    return isMouseInButtons;
  }
  
  void displayHiddenLayerZone() {
    fill(100);
    
    textFont(f,16);
    text("Hidden layer:", 20, 30);
    text("Neurons:", 20, 110);
    
    textFont(f,30);
    text(selectedHiddenLayer+1 + ":", 5, 70);
    rect(60, 50, 4, 20);
    rect(52, 58, 20, 4);
    rect(82, 58, 20, 4);
    fill(200,0,0);
    rect(69, 75, 16, 16);
    
    fill(100);
    if (hiddens.length > 0)
      text(hiddens[selectedHiddenLayer] + ":", 5, 150);
    else
      text("-1:", 5, 150);
    rect(75, 130, 4, 20);
    rect(67, 138, 20, 4);
    rect(97, 138, 20, 4);
  }
  
  void displayLearningRateZone() {
    fill(100);
    
    textFont(f,16);
    text("Learning Rate Weights:", 160, 30);
    text("Learning Rate Biases:", 160, 110);
    
    textFont(f,30);
    text(nf((float)myDFF._learningRateW, 1, myDFF.precisionMaxW) + ":", 145, 70);
    rect(280, 50, 4, 20);
    rect(272, 58, 20, 4);
    rect(302, 58, 20, 4);
    
    pushMatrix();
      translate(335, 52);
      rotate(PI/4);
      rect(0, 0, 20, 4);
    popMatrix();
    pushMatrix();
      translate(332, 67);
      rotate(-PI/4);
      rect(0, 0, 20, 4);
    popMatrix();
    
    ellipse(367, 50, 5, 5);
    rect(357, 58, 20, 4);
    ellipse(367, 70, 5, 5);
    
    text(nf((float)myDFF._learningRateB, 1, myDFF.precisionMaxB) + ":", 145, 150);
    rect(280, 130, 4, 20);
    rect(272, 138, 20, 4);
    rect(302, 138, 20, 4);
    
    pushMatrix();
      translate(335, 132);
      rotate(PI/4);
      rect(0, 0, 20, 4);
    popMatrix();
    pushMatrix();
      translate(332, 147);
      rotate(-PI/4);
      rect(0, 0, 20, 4);
    popMatrix();
    
    ellipse(367, 130, 5, 5);
    rect(357, 138, 20, 4);
    ellipse(367, 150, 5, 5);
  }
  
  void displayButtons() {
    fill(0,0,255);
    rect(415, 25, 75, 30);  // Train
    rect(415, 60, 75, 30); // Image
    rect(415, 95, 75, 30);  // Reset
    
    fill(255);
    textFont(f,16);
    
    text("TRAIN", 429, 45);
    text("IMAGE", 427, 80);
    text("RESET", 426, 115);
  }
  
  // This method is called when buton of the mouse is clicked
  void mousePressed() {
    if (isMouseInClickableZone())
    {
      if (isMouseInHiddenLayer)
        handleHiddenLayerClick();
      else if (isMouseInNeuron)
        handleNeuronClick();
      else if (isMouseInRateWeight)
        handleRateWeightClick();
      else if (isMouseInRateBias)
        handleRateBiasClick();
      else if (isMouseInButtons)
        handleButtons();
    }
  }
  
  void suppress() {
    // Suppress the selected layer if there are more than one
    if (hiddens.length > 0)
    {
      int [] newHiddens = new int[hiddens.length - 1];
      for (int i = 0; i < hiddens.length; ++i)
      {
        if (i < selectedHiddenLayer)
          newHiddens[i] = hiddens[i];
        else if (i > selectedHiddenLayer)
          newHiddens[i-1] = hiddens[i];
      }
      selectedHiddenLayer = min(selectedHiddenLayer, newHiddens.length - 1);
      hiddens = newHiddens;
      
      trained = false;
      myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
    }
  }
  
  void handleHiddenLayerClick() {
    if (mouseY > 50 && mouseY < 50 + 20)
    {
      // Selection of one layer of the hidden ones
      if (mouseX > 52 && mouseX < 52 + 20)
      {
        // "+" buton for the layers
        selectedHiddenLayer++;
        if (selectedHiddenLayer == hiddens.length)
        {
          // Add a new layer of the size of the previous one
          if (hiddens.length > 0)
            hiddens = append(hiddens, hiddens[hiddens.length - 1]);
          else
            hiddens = append(hiddens, 49);
          
          trained = false;
          myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
        }
      }
      else if (mouseX > 82 && mouseX < 82 + 20)
      {
        // "-" buton for the layers
        selectedHiddenLayer--;
        
        if (selectedHiddenLayer < 0) {
          if (hiddens.length > 0) {
            int [] newHiddens = new int[hiddens.length - 1];
            for (int i = 0; i < hiddens.length - 1; ++i)
            {
                newHiddens[i] = hiddens[i + 1];
            }
            
            if (hiddens.length > 1)
              selectedHiddenLayer = 0;
            hiddens = newHiddens;
            
            trained = false;
            myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
          } else {
            selectedHiddenLayer = -1;
          }
        }
      }
    } else {
      suppress();
    }
  }
  
  void handleNeuronClick() {
    if (hiddens.length > 0) {
      if (mouseX > 67 && mouseX < 67 + 20)
        hiddens[selectedHiddenLayer] += 1;
      else if (mouseX > 97 && mouseX < 97 + 20)
        hiddens[selectedHiddenLayer] -= 1;
      
      if (hiddens[selectedHiddenLayer] > 0) {
        trained = false;
        myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
      } else {
        suppress();
      }
    }
  }
  
  void handleRateWeightClick() {
    if (mouseX > 357) { // %
      myDFF._learningRateW *= 0.1;
      ++myDFF.precisionMaxW;
    } else if (mouseX > 330) { // x
      myDFF._learningRateW *= 10;
      --myDFF.precisionMaxW;
    } else if (mouseX > 302) // -
      myDFF._learningRateW -= 1 / pow(10, myDFF.precisionMaxW);
    else if (mouseX > 272) // +
      myDFF._learningRateW += 1 / pow(10, myDFF.precisionMaxW);
    trained = false;
  }
  
  
  void handleRateBiasClick() {
    if (mouseX > 357) { // %
      myDFF._learningRateB *= 0.1;
      ++myDFF.precisionMaxB;
    } else if (mouseX > 330) { // x
      myDFF._learningRateB *= 10;
      --myDFF.precisionMaxB;
    } else if (mouseX > 302) // -
      myDFF._learningRateB -= 1 / pow(10, myDFF.precisionMaxB);
    else // +
      myDFF._learningRateB += 1 / pow(10, myDFF.precisionMaxB);
    trained = false;
  }
  
  void handleButtons() {
    if (mouseY > 95) {
      hiddens = new int[1];
      hiddens[0] = 49;
      
      trained = false;
      
      selectedHiddenLayer = 0;
    } else if (mouseY > 60) {
      dataNum = int(random(testing_set.length));
    } else {
      trainingProcess();
    }
  }
}
