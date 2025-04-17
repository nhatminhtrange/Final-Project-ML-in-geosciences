# Final Project - Machine Learning in Geosciences
this project demonstrates how to train an Artificial Neural Network (ANN) to predict surface wavefields based on synthetic data (can use experiment data).

Key Features
- 2D SH-wave simulation using FDTD
- True model with low-velocity inclusion (void)
- Source-receiver setup for surface wave acquisition
- ANN to predict wavefield based on source-receiver geometry
- Supports arbitrary source prediction

- Input: normalized source-receiver distances
- Output: normalized surface wavefield (flattened)
- Deep Feedforward Network:
  - 512 → ReLU → 1024 → ReLU → 2048 → ReLU → Output
 - Make sure you have MATLAB with Deep Learning Toolbox
  
2. Run `main.m` to:
   - Simulate wavefields
   - Train the ANN
   - Predict wavefields for new sources

In many geophysical applications such as seismic modeling or full waveform inversion (FWI), forward simulations (e.g., using finite-difference methods) are computationally expensive and time-consuming—especially when repeated for multiple source configurations.

This project explores the use of artificial neural networks (ANNs) to learn the relationship between source-receiver geometry and the resulting seismic wavefield, with the goal of:

Replacing repeated numerical simulations with a fast, data-driven alternative.

Predicting surface or full wavefields for new source locations without solving the wave equation again.

The idea is simple but powerful: once trained on synthetic (or real) data, the ANN can act as a surrogate model, enabling fast approximations of complex wave phenomena in near real-time.




