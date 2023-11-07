export OPENAI_API_KEY='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'
## Training
python learn_policy_wikitq.py \
--data_root ../data/wikitq \
--label exp1 \
--ckpt_root ../checkpoints \
--shot_number 2 \
--prompt_format TQ-A \
--seed 2 \
--model_config bert-base-uncased \
--train_number 160 \
--cand_number 20 \
--lr 0.001 \
--epochs 20 \
--embedding_size 128 \
--batch_size 20 \
--gpu 0

# ## Training
# python learn_policy.py \
# --label exp2 \
# --ckpt_root ../checkpoints \
# --shot_number 2 \
# --prompt_format TQ-SA \
# --seed 42 \
# --model_config bert-base-uncased \
# --train_number 160 \
# --cand_number 20 \
# --lr 0.001 \
# --epochs 20 \
# --embedding_size 128 \
# --batch_size 20 \
# --gpu 0

# ## Training
# python learn_policy.py \
# --label exp3 \
# --ckpt_root ../checkpoints \
# --shot_number 2 \
# --prompt_format TQ-SA \
# --seed 2023 \
# --model_config bert-base-uncased \
# --train_number 160 \
# --cand_number 20 \
# --lr 0.001 \
# --epochs 20 \
# --embedding_size 128 \
# --batch_size 20 \
# --gpu 0