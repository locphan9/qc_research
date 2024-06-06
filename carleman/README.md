#### 1. Preparing the truncated Carleman embedding 

Consider k=2  truncation Carleman nonlinear differential equations

$$\frac{d}{dt} \begin{bmatrix}u^{(1)}\\ u^{(2)} \\ u^{(3)}\end{bmatrix}=\begin{bmatrix}A_{11} & A_{12} & A_{13} \\ 0 & A_{21} & A_{22}\\ 0 & 0 & A_{31}\end{bmatrix}\begin{bmatrix}u^{(1)}\\ u^{(2)} \u^{(3)}\end{bmatrix}$$

where $u^{(2)} = u^{(1)}\otimes u^{(1)}$ and $u^{(i)} = u^{(i-1)}\otimes u^{1}$, $u^{(1)} \in R^2$
$A_{21} = A_{11}\otimes I_2 + I_2 \otimes A_{12}$   and   $A_{31}=A_{11}\otimes I_4 + I_2 \otimes A_{21}$
#### 2. Solving the nonlinear differential equations

After the truncation matrix is determined, the differential equations are computationally solved using Euler implicit method

$$u^{(N+1)}= (I-\Delta tA)^{-1}u^{(N)}$$