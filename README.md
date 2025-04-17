# Final Project - Machine Learning in Geosciences

* Introduction

In many geophysical applications such as seismic modeling or full waveform inversion (FWI), forward simulations (e.g., using finite-difference methods) are computationally expensive and time-consuming—especially when repeated for multiple source configurations.

This project explores the use of artificial neural networks (ANNs) to learn the relationship between source-receiver geometry and the resulting seismic wavefield, with the goal of:

Replacing repeated numerical simulations with a fast, data-driven alternative.

Predicting surface or full wavefields for new source locations without solving the wave equation again.

The idea is simple but powerful: once trained on synthetic (or real) data, the ANN can act as a surrogate model, enabling fast approximations of complex wave phenomena in near real-time.




# 🧠 Wavefield Prediction Using Neural Networks

This project demonstrates a data-driven approach to predict seismic wavefields using artificial neural networks (ANNs). Instead of relying on repeated numerical simulations, a neural network is trained to directly map the source–receiver geometry to recorded wavefield responses. Once trained, the model can efficiently generate wavefield predictions for new source locations.

---

## 🔍 Motivation

Seismic wavefield modeling and inversion typically require significant computational resources, especially when handling dense source arrays. This project explores the use of neural networks as surrogate models that can rapidly approximate surface wavefield recordings, enabling faster analysis and potential integration into real-time or near real-time applications.

---

## 🔑 Key Features

- Works with 2D seismic data with horizontal motion components  
- Supports arbitrary source–receiver configurations  
- Learns the mapping between **source–receiver distances** and corresponding **wavefield recordings**  
- Predicts surface wavefield for unseen source locations  
- **Input to ANN**: normalized source–receiver distance matrix  
- **Output from ANN**: normalized seismic wavefield recordings (flattened)  
- Deep feedforward neural network architecture:  
  `512 → ReLU → 1024 → ReLU → 2048 → ReLU → Output`  
- Implemented in **MATLAB** with Deep Learning Toolbox  

---

## 📂 Project Structure

```plaintext
Wavefield-Prediction-ANN/
│
├── README.md
├── LICENSE
├── data/
│   └── seismic_dataset.mat       # Contains input geometry and wavefield data
│
├── src/
│   ├── main.m                    # Main script: load, train, and predict
│   └── Elastic2D_wavefield_fw.m  # (Optional) helper for forward simulation
│
├── figures/
│   └── true_model.png
│   └── wavefield_prediction.png





