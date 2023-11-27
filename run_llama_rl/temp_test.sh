shot_numbers=(2 4 6 8 16)

# ## Inference w/ learned checkpoint (test)
# shot_numbers=(2)
#     python run_gpt3.py \
#     --label llama_exp1_tqsa_shot${shot_number} \
#     --ckpt_root ../checkpoints \
#     --test_split test \
#     --test_number -1 \
#     --shot_number ${shot_number} \
#     --prompt_format TQ-SA \
#     --seed 0 \
#     --model_config bert-base-uncased \
#     --cand_number 20 \
#     --embedding_size 128 \
#     --gpu 0

for shot_number in "${shot_numbers[@]}"
do
    python run_gpt3.py \
    --label llama_exp1_tqsa_shot${shot_number} \
    --ckpt_root ../checkpoints \
    --test_split test \
    --test_number -1 \
    --shot_number ${shot_number} \
    --prompt_format TQ-A \
    --seed 0 \
    --model_config bert-base-uncased \
    --cand_number 20 \
    --embedding_size 128 \
    --gpu 0
done

for shot_number in "${shot_numbers[@]}"
do
    python run_gpt3.py \
    --label llama_exp2_tqsa_shot${shot_number} \
    --ckpt_root ../checkpoints \
    --test_split test \
    --test_number -1 \
    --shot_number ${shot_number} \
    --prompt_format TQ-A \
    --seed 42 \
    --model_config bert-base-uncased \
    --cand_number 20 \
    --embedding_size 128 \
    --gpu 0
done

for shot_number in "${shot_numbers[@]}"
do
    python run_gpt3.py \
    --label llama_exp3_tqsa_shot${shot_number} \
    --ckpt_root ../checkpoints \
    --test_split test \
    --test_number -1 \
    --shot_number ${shot_number} \
    --prompt_format TQ-A \
    --seed 2023 \
    --model_config bert-base-uncased \
    --cand_number 20 \
    --embedding_size 128 \
    --gpu 0
done


#######################################################
# ## Inference w/ learned checkpoint (test)
# python run_gpt3.py \
# --label exp1 \
# --ckpt_root ../checkpoints \
# --model gpt3_rl \
# --test_split test \
# --test_number -1 \
# --shot_number $shot \
# --prompt_format TQ-SA \
# --seed 2 \
# --cand_number 20 \
# --embedding_size 128 \
# --model_config bert-base-uncased \
# --ckpt exp1/ckpt_best_reward.pt \
# --gpu 0


# # Inference w/ learned checkpoint (test) ########
# python run_gpt3.py \
# --label exp2 \
# --ckpt_root ../checkpoints \
# --model gpt3_rl \
# --test_split test \
# --test_number -1 \
# --shot_number $shot \
# --prompt_format TQ-SA \
# --seed 42 \
# --cand_number 20 \
# --embedding_size 128 \
# --model_config bert-base-uncased \
# --ckpt exp2/ckpt_best_reward.pt \
# --gpu 0


# ## Inference w/ learned checkpoint (test)
# python run_gpt3.py \
# --label exp3 \
# --ckpt_root ../checkpoints \
# --model gpt3_rl \
# --test_split test \
# --test_number -1 \
# --shot_number $shot \
# --prompt_format TQ-SA \
# --seed 2023 \
# --cand_number 20 \
# --embedding_size 128 \
# --model_config bert-base-uncased \
# --ckpt exp3/ckpt_best_reward.pt \
# --gpu 0
