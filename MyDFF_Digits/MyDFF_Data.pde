double sigmoid(double x) { return 1.0 / (1.0 + exp(-1.0 * (float)x)); }

///////// TO USE A DATASET
// If you want to use a particular dataset, please implement the data structure in order to easily use the class MyDFF

class Data {
  
  double [] inputs, outputs;
  int label;
  
  Data() {
    // Choose your own sizes.
    inputs  = new double [784]; // The size should be equal to the number of neurons of your input layer.
    outputs = new double [10]; // The size should be equal to the number of neurons of your output layer.
  }
  
  // This method will allow you load your input data.
  // It can be either an image, an array, a path to a bynary file, ...
  void inputLoad(byte [] images, int offset) {
    // Do whatever you need here.
    for (int i = 0; i < inputs.length; ++i) {
      inputs[i] = int(images[i+offset]) / 255.0;
    }
  }
  
  // This method will allow you load your output data.
  // You will have to set with this function:
  //   - the expected value of each output neuron
  //   - the ID of the most activated neuron (label for convienency)
  void labelLoad(int t_label) {
    label = t_label;
    for (int i = 0; i < 10; ++i) {
      if (i == label)
        outputs[i] = 1.0;
      else
        outputs[i] = 0.0;
    }
  }
}

///////// TO IMPORT A DATASET
// After implementing the previous class, you can now use it to import your own dataset.

Data [] testing_set;
Data [] training_set;

void loadData() {
  training_set = new Data[60000]; // Choose the size of the amount of training data you want to import.
  testing_set  = new Data[10000]; // Choose the size of the amount of testing data you want to import.
  
  // Now, use the inputLoad() and labelLoad() for each Datas of training_set and testing_set.
  
  byte [] training_images = loadBytes("train-images.idx3-ubyte");
  byte [] training_labels = loadBytes("train-labels.idx1-ubyte");
  
  byte [] testing_images = loadBytes("t10k-images.idx3-ubyte");
  byte [] testing_labels = loadBytes("t10k-labels.idx1-ubyte");
  
  for (int i = 0; i < 60000; ++i) {
    training_set[i] = new Data();
    training_set[i].inputLoad(training_images, 16 + i * 784); // Offset of 16 bytes
    training_set[i].labelLoad(int(training_labels[8 + i]));   // Offset of 8 bytes
  }
  
  for (int i = 0; i < 10000; ++i) {
    testing_set[i] = new Data();
    testing_set[i].inputLoad(testing_images, 16 + i * 784); // Offset of 16 bytes
    testing_set[i].labelLoad(testing_labels[8 + i]);       // Offset of 8 bytes
  }
}
