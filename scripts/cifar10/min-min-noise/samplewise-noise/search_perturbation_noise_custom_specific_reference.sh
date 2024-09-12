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

reference_class_indices=(0 1 2 3 4 5 6 7 8 9)
seed=0

for reference_class_idx in $reference_class_indices;
do
    for j in {0..9}; 
    do
        if [ $j -eq $reference_class_idx ]; then
            continue
        fi
        noise_name="${cifar10_classes[$reference_class_idx]}-${cifar10_classes[$j]}"
        classes="${reference_class_idx} ${j}"
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
                                --selected_classes        $classes            \
                                --seed                    $seed
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
