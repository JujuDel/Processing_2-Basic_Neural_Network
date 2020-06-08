class MyDFF {
  
  Network _network;
  
  double _accuracy      = 0.;
  double _avrgError     = 0.;
  
  double _learningRateW = 0.3;
  double _learningRateB = 0.001;
  
  int precisionMaxW = 1, precisionMaxB = 3; // Added
  
  MyDFF(int nbInputs, int[] nbHiddens, int nbOutput) {
    _network = new Network(nbInputs, nbHiddens, nbOutput);
  }
  
  //// With Data Structure
  // Please see DataTreatment file to have more detailsw
  
  int respond(Data data) {
    return respond(data.inputs);
  }
  
  int train(Data [] datas) {
    if (datas.length > 0) {
      for (Data data : datas) {
        if (data.inputs.length  == _network.m_input_layer.neurons.length &&
            data.outputs.length == _network.m_output_layer.neurons.length)
        {
          _network.respond(data.inputs);
          _network.train(data.outputs, _learningRateW, _learningRateB);
        } else {
          println("MyDFF::train(Data []) method -> invalid inputs or outputs size");
          return -1;
        }
      }
    } else {
      println("MyDFF::train(Data []) method -> invalid size of the argument");
      return -1;
    }
    return 1;
  }
  
  int test(Data [] datas) {
    if (datas.length > 0) {
      _accuracy = 0;
      _avrgError = 0;
      for (Data data : datas) {
        if (data.inputs.length == _network.m_input_layer.neurons.length) {
          _network.respond(data.inputs);
          
          if (_network.findIndexBestOutput() == data.label)
            _accuracy++;
          
          _avrgError += _network.computeTotalError(data.label);
        } else {
          println("MyDFF::train(Data []) method -> invalid inputs size");
          return -1;
        }
      }
      _accuracy = _accuracy / (double)(datas.length);
      _avrgError = _avrgError / (double)(datas.length);
      println("Accuracy: ", _accuracy);
      println("Average Error: ", nf((float)_avrgError, 0, 4));
    } else {
      println("MyDFF::train(Data []) method -> invalid size of the arguments");
      return -1;
    }
    return 1;
  }
  
  //// Without Data Structure
  
  int respond(double[] inputs) {
    if (inputs.length == _network.m_input_layer.neurons.length) {
      _network.respond(inputs);
      return _network.findIndexBestOutput();
    } else {
      println("MyDFF::respond(double[]) method -> invalid size of the argument");
    }
    return -1;
  }
  
  int train(double [][] trainingInput, double [][] trainingOutput) {
    if (trainingInput.length == trainingOutput.length &&
        trainingInput[0].length == _network.m_input_layer.neurons.length &&
        trainingOutput[0].length == _network.m_output_layer.neurons.length) {
      for (int i = 0; i < trainingInput.length; ++i) {
        _network.respond(trainingInput[i]);
        _network.train(trainingOutput[i], _learningRateW, _learningRateB);
      }
    } else {
      println("MyDFF::train(double[][], double[][]) method -> invalid size of the arguments");
      return -1;
    }
    return 1;
  }
  
  int test(double [][] testingInput, int [] IDofLabeledNeuron) {
    if (testingInput[0].length == _network.m_input_layer.neurons.length &&
        testingInput.length == IDofLabeledNeuron.length) {
      _accuracy = 0;
      _avrgError = 0;
      for (int i = 0; i < testingInput.length; ++i)
      {
        _network.respond(testingInput[i]);
        
        if (_network.findIndexBestOutput() == IDofLabeledNeuron[i])
          _accuracy++;
          
        _avrgError += _network.computeTotalError(IDofLabeledNeuron[i]);
      }
      _accuracy = _accuracy / (double)(testingInput.length);
      _avrgError = _avrgError / (double)(testingInput.length);
      println("Accuracy: ", _accuracy);
      println("Average Error: ", nf((float)_avrgError, 0, 4));
    } else {
      println("MyDFF::test(double[][], int[]) method -> invalid size of the arguments");
      return -1;
    }
    return 1;
  }
  
  //// Added methods
  
  void blank() {
    _network.blank();
  }
  
  void display(int found, int label) {
    _network.display(found, label);
  }
}
