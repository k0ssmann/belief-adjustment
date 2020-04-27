# Belief-Adjustment-Model

Implementation of the Belief-Adjustment-Model by Hogarth & Einhorn (1992)

## Getting Started

Just clone this repository into an directory
```
git clone https://github.com/k0ssmann/belief-adjustment
```

### Prerequisites

* R version >= 3.6.3

## Basic usage

Insert subjective evaluations of evidence in subjective_evidence. However, note that the value range depends on the used mode. 
If applying an evaluation task, elements of subjective_evidence can take values between [-1, 1].
In estimation tasks elements of subjective_evidence should take values between [0, 1].
Next, set the initial strength of belief initial_strength, where 0 <= initial_strength <= 1.
For example, setting initial_strength to 0.5 can be interpreted as a neutral belief in some hypothesis.
Furthermore, you can change alpha and beta, where 0 <= (alpha, beta) <= 1. Alpha represents the sensitivity
to negative evidence, beta the sensitivity to positive evidence. For example, beta = 0 and alpha = 1 represents the position
of the skeptic who is highly sensitive to negative evidence but ignores positive evidence. Beta = 1 and alpha = 0
represents the advocate who ignores negative evidence but is highly sensitive to positive evidence.
Finally, select the mode (evaluation or estimation) and the process (Step-by-Step, or End-of-Sequence).
However, Estimation mode x End-of-Sequence process is not possible and will result in an error message.

## References

Hogarth, R. M., & Einhorn, H. J. (1992). Order effects in belief updating: The belief-adjustment model. 
Cognitive Psychology, 24(1), 1–55. doi: 10.1016/0010-0285(92)90002-j 
