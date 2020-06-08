AppletParametersHandling aParam;

int nbInputs = 784;
int nbOutputs = 10;

// For the selection of one data amoung all of them
int dataNum;

// To know if the netwok has been trained
boolean trained = false;

// For UX: the selected hidden layer with the bouttons
int selectedHiddenLayer = 0;

// To set the number of neurons per hidden layer
int [] hiddens;

// for the display
PFont f;
  
// The DFF NN
MyDFF myDFF;

void settings() {
  size(800, 300);
}

// This method is call only once when the sketch starts
void setup() {
  f = createFont("Arial",16,true);
    
  surface.setTitle("Neural Network");
  
  // For the display: strength of the ellipses' contour
  stroke(125);
  
  // Load the training and testing sets
  // 80% in the training set
  // 20% in the testing set
  loadData();
  
  // Set the number of hidden layers and the number of neurons per layers
  hiddens = new int[1];
  hiddens[0] = 300;
  
  myDFF = new MyDFF(nbInputs, hiddens, nbOutputs);
  
  // Select randomly one digit
  dataNum = (int)random(testing_set.length);
 
  String[] argsParam = {"Learning Rate"};
  aParam = new AppletParametersHandling();
  PApplet.runSketch(argsParam, aParam);
}

void draw() {
  background(255);
  
  displayDFF(myDFF, dataNum);
  displayAccuracy(myDFF._accuracy);
  displayError(myDFF._avrgError);
}

void trainingProcess() {
  // Train the DFF NN: adapt the weights and biases
  myDFF.train(training_set);
  
  // Test the DFF NN: compute the accuracy
  myDFF.test(testing_set);
  
  // If the model has been validated, train on the whole dataset
  if (myDFF._accuracy > 0.9) {
    println("The model has been validated, congratulations !!!");
  } else {
    println("The model is not validated...");
  }
  
  trained = true;
}
