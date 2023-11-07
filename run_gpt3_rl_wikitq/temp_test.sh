shot=8
export OPENAI_API_KEY='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'

## Inference w/ learned checkpoint (test)
python run_gpt3_wikitq.py \
--data_root ../data/wikitq \
--label exp1 \
--ckpt_root ../checkpoints \
--model gpt3_rl \
--test_split test \
--test_number -1 \
--shot_number $shot \
--prompt_format TQ-A \
--seed 2 \
--cand_number 20 \
--embedding_size 128 \
--model_config bert-base-uncased \
--ckpt exp1/ckpt_best_reward.pt \
--gpu 0


# ## Inference w/ learned checkpoint (test)
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
