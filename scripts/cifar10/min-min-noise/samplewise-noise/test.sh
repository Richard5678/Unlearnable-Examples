# random_permutations=(
#   "2 8 4 9 1 6 7 3 0 5"
#   "2 9 6 4 0 3 1 7 8 5"
#   "4 1 5 0 7 2 3 6 9 8"
#   "5 4 1 2 9 6 7 0 3 8"
#   "3 8 4 9 2 6 0 1 5 7"
#   "9 5 2 4 7 1 0 8 6 3"
#   "8 1 7 0 6 5 2 4 3 9"
#   "8 5 0 2 1 9 7 3 6 4"
#   "8 6 9 0 2 5 7 1 4 3"
#   "8 4 7 2 1 9 3 0 6 5"
# )

# cifar10_classes=(
#   "airplane"
#   "automobile"
#   "bird"
#   "cat"
#   "deer"
#   "dog"
#   "frog"
#   "horse"
#   "ship"
#   "truck"
# )

# for seed in {0..9}
# do
#     list=(${random_permutations[$seed]})  # Convert string to array
#     for j in {1..9}; do
#         noise_name="${cifar10_classes[list[0]]}-${cifar10_classes[list[$j]]}"
#         classes="${list[0]} ${list[$j]}"
#         echo $noise_name
#         echo $classes

#         noise_file_name="ue-cifar10-${noise_name}_seed=${seed}"
#         echo $noise_file_name
#     done
# done

for seed in {5..9}
do  
    echo $seed
done