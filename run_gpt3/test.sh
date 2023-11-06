shot=0

python run_gpt3.py \
--label exp1 \
--test_split test \
--test_number -1 \
--shot_number $shot \
--prompt_format TQ-A \
--seed 2

# python run_gpt3.py \
# --label exp2 \
# --test_split test \
# --test_number -1 \
# --shot_number $shot \
# --prompt_format TQ-A \
# --seed 42

# python run_gpt3.py \
# --label exp3 \
# --test_split test \
# --test_number -1 \
# --shot_number $shot \
# --prompt_format TQ-A \
# --seed 2023
