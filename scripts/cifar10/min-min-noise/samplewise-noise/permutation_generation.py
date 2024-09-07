import numpy as np


for seed in range(10):
  # Seed numpy
  np.random.seed(seed)

  # Generate a random permutation of numbers from 0 to 9
  random_permutation = np.random.permutation(10)

  # Print the result
  print(f"Random permutation of 0 to 9 with seed {seed}: {random_permutation}")