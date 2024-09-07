#!/bin/bash

# Load Exp Settings
source exp_setting.sh


# Remove previous files
echo $exp_path

cd ../../../../
pwd
echo $exp_path
# Check if the directory exists before attempting to remove it
if [ -d "$exp_path" ]; then
    # Remove the directory
    rm -rf "$exp_path"
    echo "Directory '$exp_path' has been removed."
else
    echo "Directory '$exp_path' does not exist."
fi

random_permutations=(
  "2 8 4 9 1 6 7 3 0 5"
  "2 9 6 4 0 3 1 7 8 5"
  "4 1 5 0 7 2 3 6 9 8"
  "5 4 1 2 9 6 7 0 3 8"
  "3 8 4 9 2 6 0 1 5 7"
  "9 5 2 4 7 1 0 8 6 3"
  "8 1 7 0 6 5 2 4 3 9"
  "8 5 0 2 1 9 7 3 6 4"
  "8 6 9 0 2 5 7 1 4 3"
  "8 4 7 2 1 9 3 0 6 5"
)

cifar10_classes=(
  "airplane"
  "automobile"
  "bird"
  "cat"
  "deer"
  "dog"
  "frog"
  "horse"
  "ship"
  "truck"
)

noise_name_classes_pairs=(
    "bird-cat:2 3" 
    "bird-deer:2 4"
    "cat-ship:3 8"
    "cat-dog:3 5" 
    "ship-truck:8 9"
    "airplane-cat:0 3"
    "automobile-cat:1 3"
    "cat-deer:3 4"
    "cat-frog:3 6"
    "cat-horse:3 7"
    "cat-truck:3 9"
)

for seed in {0..9}
do
    # echo "List $((i+1)):"
    # list=(${array[$seed]})  # Convert string to array
    # for j in {1..9}; do
    #     echo "(${list[0]}, ${list[$j]})"
    # done
    # for noise_name_classes_pair in "${noise_name_classes_pairs[@]}"
    # do
    #     IFS=':' read -r -a pair <<< "$noise_name_classes_pair"
    #     noise_name=${pair[0]}
    #     classes=${pair[1]}
    #     echo $noise_name
    #     echo $classes

    #     noise_file_name="ue-cifar10-${noise_name}_seed=${seed}"

    list=(${random_permutations[$seed]})  # Convert string to array
    for j in {1..9}; do
        noise_name="${cifar10_classes[list[0]]}-${cifar10_classes[list[$j]]}"
        classes="${list[0]} ${list[$j]}"
        echo $noise_name
        echo $classes

        noise_file_name="ue-cifar10-${noise_name}_seed=${seed}"
        echo $noise_file_name

        # Search Universal Perturbation and build datasets
        python3 perturbation.py --config_path             $config_path       \
                                --exp_name                $exp_path          \
                                --version                 $base_version      \
                                --train_data_type         $dataset_type      \
                                --noise_shape             10000 3 32 32      \
                                --epsilon                 $epsilon           \
                                --num_steps               $num_steps         \
                                --step_size               $step_size         \
                                --attack_type             $attack_type       \
                                --perturb_type            $perturb_type      \
                                --universal_train_target  $universal_train_target\
                                --universal_stop_error    $universal_stop_error\
                                --noise_name              $noise_file_name     \
                                --selected_classes        $classes
    done
done


# # Search Universal Perturbation and build datasets
# cd ../../../../
# pwd
# rm -rf $exp_name
# python3 perturbation.py --config_path             $config_path       \
#                         --exp_name                $exp_path          \
#                         --version                 $base_version      \
#                         --train_data_type         $dataset_type      \
#                         --noise_shape             10000 3 32 32      \
#                         --epsilon                 $epsilon           \
#                         --num_steps               $num_steps         \
#                         --step_size               $step_size         \
#                         --attack_type             $attack_type       \
#                         --perturb_type            $perturb_type      \
#                         --universal_train_target  $universal_train_target\
#                         --universal_stop_error    $universal_stop_error\
#                         --noise_name             $noise_name        \
