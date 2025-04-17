# MLcourse
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






