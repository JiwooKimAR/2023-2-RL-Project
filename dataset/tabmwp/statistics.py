import re
import json
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from functools import reduce

# from PromptPG
def convert_table_text_to_pandas(table_text):
    _data = {}

    table_text = re.sub(r" ?\| ?", " | ", table_text)
    cells = [row.split(" | ") for row in table_text.split("\n")]

    row_num = len(cells)
    column_num = len(cells[0])

    # for table without a header
    first_row = cells[0]
    matches = re.findall(r"[\d]+", " ".join(first_row))
    if len(matches) > 0:
        header = [f"Column {i+1}" for i in range(column_num)]
        cells.insert(0, header)

    # build DataFrame for the table
    for i in range(column_num):
        _data[cells[0][i]] = [row[i] for row in cells[1:]]

    table_pd = pd.DataFrame.from_dict(_data)

    return table_pd


def print_rule1(option, ttt):
    print(f'\t- {option}:')
    print(f'\t\t- min: {np.min(ttt)}, mean: {np.mean(ttt):.2f}, median: {np.median(ttt)}, max: {np.max(ttt)}')
    pds = pd.Series(ttt)
    print(f'\t\t25%: {pds.quantile(0.25)}, 50%: {pds.quantile(0.50)}, 75%: {pds.quantile(0.75)}, 100%: {pds.quantile(1)}')

def print_rule2(first ,second, ttt, title, axs):
    axs[first, second].hist(ttt)
    axs[first, second].set_title(title)

def get_quantile_index(q_prev, q_now, ttt):
    pds = pd.Series(ttt)
    prev, now = pds.quantile(q_prev), pds.quantile(q_now)
    return np.intersect1d(np.where(ttt >= prev), np.where(ttt < now))

def get_intersaction_index(q_prev, q_now, tt):
    index0 = get_quantile_index(q_prev, q_now, tt['num_of_table_rows'])
    index1 = get_quantile_index(q_prev, q_now, tt['num_of_table_cells'])
    index2 = get_quantile_index(q_prev, q_now, tt['question_length'])
    index3 = get_quantile_index(q_prev, q_now, tt['solution_length'])
    return reduce(np.intersect1d, (index0, index1, index2, index3))

def get_statistics(train, dev, test):
    stt = []

    for target in [train, dev, test]:
        statistic_dict = {
            'ques_type': {'free_text': 0, 'multi_choice': 0},
            'num_of_table_columns': [],
            'num_of_table_rows': [],
            'num_of_table_cells': [],
            'question_length': [],
            'answer_length': [],
            'solution_length': []
        }

        for k, v in target.items():
            # Data distribution
            '''
            주의 깊게 봐야 할 attributes:
            - ques_type: free_text, multi_choice
            - # of table columns, # of table rows, # of table cells: convert_table_text_to_pandas(table_for_pd)
            - question_length: question
            - answer_length: answer,
            - solution_length: solution
            '''
            # v['table_df'] = convert_table_text_to_pandas(v['table'])

            statistic_dict['ques_type'][v['ques_type']] += 1
            statistic_dict['num_of_table_columns'].append(int(v['column_num']))
            statistic_dict['num_of_table_rows'].append(int(v['row_num']))
            statistic_dict['num_of_table_cells'].append(int(v['column_num']) * int(v['row_num']))
            statistic_dict['question_length'].append(len(v['question'].split()))
            statistic_dict['answer_length'].append(len(v['answer'].split()))
            statistic_dict['solution_length'].append(len(v['solution'].split()))

        for k, v in statistic_dict.items():
            if k == 'ques_type':
                continue
            statistic_dict[k] = np.array(v)
        stt.append(statistic_dict)

    return stt

def generate_figure(stt, name):
    fig, axs = plt.subplots(nrows=3, ncols=6, figsize=(15, 5))
    for idx in range(3):
        print_rule2(idx, 0, stt[idx]['num_of_table_columns'], '# of table columns', axs)
        print_rule2(idx, 1, stt[idx]['answer_length'], 'answer length', axs)
        print_rule2(idx, 2, stt[idx]['num_of_table_rows'], '# of table rows', axs)
        print_rule2(idx, 3, stt[idx]['num_of_table_cells'], '# of table cells', axs)
        print_rule2(idx, 4, stt[idx]['question_length'], 'question length', axs)
        print_rule2(idx, 5, stt[idx]['solution_length'], 'solution length', axs)

    fig.tight_layout()
    plt.savefig(f'{name}.png')

if __name__=='__main__':
    np.random.seed(0)

    # Load files
    train_path = 'problems_train.json'
    dev_path = 'problems_dev.json'
    test_path = 'problems_test.json'

    with open(train_path, 'r') as f:
        train = json.load(f)
    with open(dev_path, 'r') as f:
        dev = json.load(f)
    with open(test_path, 'r') as f:
        test = json.load(f)

    # Get statistics of original data
    stt = get_statistics(train, dev, test)

    # Generate a figure
    generate_figure(stt, 'stt_fig')

    # Statistics
    subsets = []
    for idx, (target, target_str) in enumerate(zip([train, dev, test], ['train', 'dev', 'test'])):
        tt = stt[idx]
        print(f'TabMWP {target_str} statistics')

        print(f'\t- # of free-test questions: {tt["ques_type"]["free_text"]}')
        print(f'\t- # of multi-choice questions: {tt["ques_type"]["multi_choice"]}')

        print_rule1('# of table columns', tt['num_of_table_columns'])
        print_rule1('answer length', tt['answer_length'])
        print_rule1('# of table rows', tt['num_of_table_rows'])
        print_rule1('# of table cells', tt['num_of_table_cells'])
        print_rule1('question length', tt['question_length'])
        print_rule1('solution length', tt['solution_length'])

        print()

        # Make subset
        q1 = get_intersaction_index(0.0, 0.25, tt)
        q2 = get_intersaction_index(0.25, 0.50, tt)
        q3 = get_intersaction_index(0.50, 0.75, tt)
        q4 = get_intersaction_index(0.75, 1.0, tt)

        print(f'\t- len(q1): {len(q1)}, len(q2): {len(q2)}, len(q3): {len(q3)}, len(q4): {len(q4)}')
        
        size = 25
        random_idx = np.concatenate([
            np.random.choice(q1, size=size, replace=False),
            np.random.choice(q2, size=size, replace=False),
            np.random.choice(q3, size=size, replace=False),
            np.random.choice(q4, size=size, replace=False),
            ])

        subset, target_key_list = dict(), list(target.keys())
        for idx in random_idx:
            k = target_key_list[idx]
            v = target[k]
            subset[k] = v

        assert len(subset) == size * 4

        subsets.append(subset)

        with open(f'{target_str}.json', 'w') as f:
            json.dump(subset, f, ensure_ascii=False, indent=4)
    
    # Get statistics of part of data
    stt_part = get_statistics(subsets[0], subsets[1], subsets[2])

    # Generate a figure
    generate_figure(stt_part, 'stt_part_fig')

        
