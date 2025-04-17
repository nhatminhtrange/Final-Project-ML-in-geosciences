# Final Project - Machine Learning in Geosciences

* Introduction

In many geophysical applications such as seismic modeling or full waveform inversion (FWI), forward simulations (e.g., using finite-difference methods) are computationally expensive and time-consuming—especially when repeated for multiple source configurations.

This project explores the use of artificial neural networks (ANNs) to learn the relationship between source-receiver geometry and the resulting seismic wavefield, with the goal of:

Replacing repeated numerical simulations with a fast, data-driven alternative.

Predicting surface or full wavefields for new source locations without solving the wave equation again.

The idea is simple but powerful: once trained on synthetic (or real) data, the ANN can act as a surrogate model, enabling fast approximations of complex wave phenomena in near real-time.




# 🧠 Wavefield Prediction Using Neural Networks

This project demonstrates a data-driven approach to predict seismic wavefields using artificial neural networks (ANNs). Instead of repeatedly solving wave equations (e.g., via FDTD), we use ANNs to learn the relationship between source–receiver geometry and the corresponding wavefield. Once trained, the network can quickly predict surface or full wavefields for arbitrary source locations.

---

## 🔍 Motivation

Forward simulations of seismic wave propagation are computationally expensive, especially in full waveform inversion (FWI) or sensitivity studies involving many sources. This project addresses that challenge by training a neural network on synthetic wavefield data, enabling near-instantaneous prediction of seismic responses without needing to solve the underlying PDE again.

---

## 🔑 Key Features

- Uses synthetic or real wavefield data (horizontal component)  
- Includes a customizable velocity and density model with anomalies  
- Source–receiver configuration for surface acquisition  
- **ANN predicts wavefields** based on source–receiver geometry  
- Supports wavefield prediction for **new, unseen source locations**  
- **Input to ANN**: normalized source–receiver distances  
- **Output from ANN**: normalized surface wavefield (flattened)  
- Deep feedforward network architecture:  
  `512 → ReLU → 1024 → ReLU → 2048 → ReLU → Output`  
- Implemented in **MATLAB** with Deep Learning Toolbox support  

---

## 📂 Project Structure

```plaintext
Wavefield-Prediction-ANN/
│
├── README.md                 # Project documentation
├── LICENSE                  # Optional: MIT or your preferred license
├── data/
│   └── 1st round_big.mat     # True model: velocity and density
│
├── src/
│   ├── main.m                # Main script: simulation + training + prediction
│   ├── Elastic2D_wavefield_fw.m  # Forward simulation (FDTD)
│   └── network_training.m    # (Optional) ANN training logic
│
├── figures/
│   └── true_model.png
│   └── wavefield_prediction.png
│
└── utils/
    └── (optional helper functions)




