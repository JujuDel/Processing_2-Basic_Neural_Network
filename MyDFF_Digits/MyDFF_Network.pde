class Network {
  
  Layer m_input_layer;
  Layer [] m_hidden_layer;
  Layer m_output_layer;
  
  Network(int inputs, int [] hiddens, int outputs) {
    m_input_layer = new Layer(inputs);
    
    m_hidden_layer = new Layer [hiddens.length];
    if (m_hidden_layer.length > 0 ) {
      m_hidden_layer[0] = new Layer(hiddens[0], m_input_layer);
      for (int i = 1; i < m_hidden_layer.length; ++i) {
        m_hidden_layer[i] = new Layer(hiddens[i], m_hidden_layer[i-1]);
      }
      m_output_layer = new Layer(outputs, m_hidden_layer[m_hidden_layer.length - 1]);
    } else {
      m_output_layer = new Layer(outputs, m_input_layer);
    }
  }
  
  void respond(double[] data) {
    for (int i = 0; i < m_input_layer.neurons.length; ++i) {
      m_input_layer.neurons[i].m_output = data[i];
    }
    
    for (int i = 0; i < m_hidden_layer.length; ++i) {
      m_hidden_layer[i].respond();
    }
    
    m_output_layer.respond();
  }
  
  void train(double [] targets, double learningRateW, double learningRateB) {
    // adjust the output layer
    for (int i = 0; i < m_output_layer.neurons.length; ++i) {
      m_output_layer.neurons[i].setError(targets[i]);
      m_output_layer.neurons[i].train(learningRateW, learningRateB);
    }
    
    // propagate back to the hidden layers
    for (int i = m_hidden_layer.length - 1; i >= 0 ; --i) {
      m_hidden_layer[i].train(learningRateW, learningRateB);
    }
  }
  
  int findIndexBestOutput()
  {
    double maxOutput = -1;
    int foundedLabel = -1;
    for (int i = 0; i < m_output_layer.neurons.length; ++i) {
      if (m_output_layer.neurons[i].m_output > maxOutput)
      {
        maxOutput = m_output_layer.neurons[i].m_output;
        foundedLabel = i;
      }
    }
    
    return foundedLabel;
  }
  
  //// Added methods
  
  void blank() {
    m_input_layer.blank();
    
    for (int i = 0; i < m_hidden_layer.length; ++i) {
      m_hidden_layer[i].blank();
    }
    
    m_output_layer.blank();
  }
  
  double computeTotalError(int label) {
    double err = 0;
    
    for (int i = 0; i < m_output_layer.neurons.length; ++i) {
      double output = m_output_layer.neurons[i].m_output;
      if (i == label)
        err += (1 - output) * (1 - output);
      else
        err += output * output;
    }
    
    return err;
  }
  
  void display(int found, int label) {
    
    m_input_layer.displayInput(10+16, 30, 8, 28);
    
    int nbExtraRow = 0;
    for (int i = 0; i < m_hidden_layer.length; ++i) {
      nbExtraRow += m_hidden_layer[i].displayHidden(260 + (i + nbExtraRow)*21, 30, 16, 13);
    }
    
    m_output_layer.displayOutput(720, 48, 16, found, label);   
  }
}
