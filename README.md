# Final Project – Machine Learning in Geosciences

## 📌 Introduction

In field geophysical surveys, the ability to design and evaluate acquisition configurations—such as source and receiver placement—is essential for collecting useful seismic data. However, practical limitations often arise: not enough geophones, missing source positions, difficult terrain, or time constraints. 

This project explores the use of **artificial neural networks (ANNs)** to learn the relationship between **source–receiver geometry** and the resulting **seismic wavefield**. Using **synthetic data as a proxy for field data**, the trained model can help:


- Predict wavefield recordings at the surface for new or missing source positions.
- Assist in the design and evaluation of field test configurations.
- Provide insight into the sensitivity of wavefields to acquisition geometry.

Once trained, the ANN can approximate wavefield responses for different geometries without testing, offering a flexible tool for supporting survey design and decision-making.


---

## 🧠 Wavefield Prediction Using Neural Networks

This project presents a data-driven approach for predicting seismic wavefields using a feedforward artificial neural network (ANN). Instead of physically collecting seismic data for every possible source–receiver configuration, the ANN is trained to learn the underlying relationship between acquisition geometry and the resulting wavefield. Once trained, the model can predict wavefield responses for new or missing source positions, offering a flexible tool for survey design and planning.

### How It Works

- **Input to ANN**: Normalized source–receiver geometry (e.g., relative distance matrix).
- **Output from ANN**: Normalized seismic wavefield recordings at the surface.
- **Architecture**: Deep feedforward neural network with ReLU activations:

[ANN Architecture (Example from https://alexlenail.me/NN-SVG/)](https://alexlenail.me/NN-SVG/)

![Truemodel](figure\ANN.png)


- **Training Data**: Synthetic wavefields generated using finite-difference simulations.
- **Target Use**: Predicting full surface wavefield for unseen or hypothetical source positions.

---

## 🔑 Key Features

- Works with 2D seismic wavefield data (e.g., horizontal component).
- Supports arbitrary source–receiver configurations.
- Learns the geometry-to-wavefield mapping from synthetic data.
- Predicts wavefield responses for new source positions.
- Implemented in MATLAB using the Deep Learning Toolbox.

---

## 📂 Project Structure


---

## 📊 Example Outputs

**True model to generate wave field**

![Truemodel](figure\Truemodel.png)

**Test configuration**

![Test Configuration](figure\testconfigure.png)

**Measured data recorded at the first source**

![Measured data](figure\DD.png)

**Predicted data**

![Wavefield at Beginning](figure\Wavefield1.png)

![Wavefield at Middle](figure\Wavefield2.png)

![Wavefield at End](figure\Wavefield3.png)

---

## ✅ Potential Applications

- Planning seismic surveys with incomplete or limited equipment
- Testing different source layouts virtually before field deployment
- Estimating wavefield coverage with fewer measurements
- Educating or demonstrating wave propagation behavior interactively

---

## 🛠️ Requirements

- MATLAB R2021a or later
- Deep Learning Toolbox
- (Optional) Parallel Computing Toolbox for faster training

---

## 📬 Contact

For questions or suggestions, feel free to reach out!
Email: tran.nhat@ufl.edu
---

© 2025 – Final Project for Machine Learning in Geosciences

