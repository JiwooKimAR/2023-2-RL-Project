# shot_numbers=(2 4 6 8 16)
shot_numbers=2

python learn_policy.py \
--label llama_exp3_tqsa_shot${shot_number} \
--ckpt_root ../checkpoints \
--shot_number ${shot_number} \
--prompt_format TQ-A \
--seed 2023 \
--model_config bert-base-uncased \
--train_number 160 \
--cand_number 20 \
--lr 0.001 \
--epochs 20 \
--embedding_size 128 \
--batch_size 20 \
--gpu 0


# for shot_number in "${shot_numbers[@]}"
# do
#     python learn_policy.py \
#     --label llama_exp1_baseline_shot${shot_number} \
#     --ckpt_root ../checkpoints \
#     --shot_number ${shot_number} \
#     --prompt_format TQ-A \
#     --seed 0 \
#     --model_config bert-base-uncased \
#     --train_number 160 \
#     --cand_number 20 \
#     --lr 0.001 \
#     --epochs 20 \
#     --embedding_size 128 \
#     --batch_size 20 \
#     --gpu 0
# done

# for shot_number in "${shot_numbers[@]}"
# do
#     python learn_policy.py \
#     --label llama_exp2_baseline_shot${shot_number} \
#     --ckpt_root ../checkpoints \
#     --shot_number ${shot_number} \
#     --prompt_format TQ-A \
#     --seed 42 \
#     --model_config bert-base-uncased \
#     --train_number 160 \
#     --cand_number 20 \
#     --lr 0.001 \
#     --epochs 20 \
#     --embedding_size 128 \
#     --batch_size 20 \
#     --gpu 0
# done

# for shot_number in "${shot_numbers[@]}"
# do
#     python learn_policy.py \
#     --label llama_exp3_baseline_shot${shot_number} \
#     --ckpt_root ../checkpoints \
#     --shot_number ${shot_number} \
#     --prompt_format TQ-A \
#     --seed 2023 \
#     --model_config bert-base-uncased \
#     --train_number 160 \
#     --cand_number 20 \
#     --lr 0.001 \
#     --epochs 20 \
#     --embedding_size 128 \
#     --batch_size 20 \
#     --gpu 0
# done
