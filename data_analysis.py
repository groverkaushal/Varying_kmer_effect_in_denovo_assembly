import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as mpatches

kmer_list = np.arange(39,152,8).tolist()

formatt = pd.read_csv("./format.txt",sep="\t").set_index("Unnamed: 0")
# a = formatt.copy()

a = pd.concat([formatt]*len(kmer_list), axis=1)
a.columns = [f'{col}_{i+1}' for i in range(len(kmer_list)) for col in formatt.columns]



for index,ff in enumerate(kmer_list):
    for i in range(3):
        if i == 0:
            temp = pd.read_csv("./abyss_outputs/k" + str(ff) + "-kc2/ecoli-scaffolds.fa_n50_stat",sep="\t", names=["value"])
            temp_l50 = pd.read_csv("./abyss_outputs/k" + str(ff) + "-kc2/abyss-fac_stat",sep="\t").iloc[2,2]
        if i == 1:
            temp = pd.read_csv("./abyss_outputs/k" + str(ff) + "-kc3/ecoli-scaffolds.fa_n50_stat",sep="\t", names=["value"])
            temp_l50 = pd.read_csv("./abyss_outputs/k" + str(ff) + "-kc3/abyss-fac_stat",sep="\t").iloc[2,2]
        if i == 2:
            temp = pd.read_csv("./velvet_outputs/k" + str(ff) + "/contigs.fa_n50_stat",sep="\t", names=["value"])
            temp_l50 = pd.read_csv("./velvet_outputs/k" + str(ff) + "/abyss-fac_stat",sep="\t").iloc[0,2]


        a.iloc[0,index*3+i] = float(temp.iloc[0,0][26:])
        a.iloc[1,index*3+i] = float(temp.iloc[1,0][26:])
        a.iloc[2,index*3+i] = float(temp.iloc[7,0][26:])
        a.iloc[3,index*3+i] = float(temp.iloc[9,0][26:])
        a.iloc[4,index*3+i] = temp_l50
        a.iloc[5,index*3+i] = float(temp.iloc[4,0][26:])
        a.iloc[6,index*3+i] = float(temp.iloc[2,0][26:])
        a.iloc[7,index*3+i] = float(temp.iloc[3,0][26:])
        a.iloc[8,index*3+i] = float(temp.iloc[17,0][26:-2])



df = pd.DataFrame(a)

legend_labels = ['abyss_kc2', 'abyss_kc3', 'velvet']
legend_colors = ['red', 'green', 'blue']
colors = ['red', 'green', 'blue','white']


groups = kmer_list
for i in range(len(groups)):
    groups[i] = "k" + str(groups[i])

x_positions = [i * 4 for i in range(len(groups))]


for index, row in df.iterrows():
    plt.figure(figsize=(10, 6))

    modified_list = []
    for i, value in enumerate(row):
        modified_list.append(value)
        if (i + 1) % 3 == 0:
            modified_list.append(0)  # Add 0 after every third element
    
    plt.bar(np.arange(0,len(kmer_list)*4,1), modified_list, color=colors * int(len(row)/4))
    plt.title(index)
    plt.xlabel('Columns')
    plt.ylabel('Values')
    # plt.xticks(rotation=90)
    plt.xticks(x_positions, groups)
    legend_patches = [mpatches.Patch(color=color, label=label) for color, label in zip(legend_colors, legend_labels)]
    plt.legend(handles=legend_patches)
    plt.tight_layout()
    plt.savefig("./plots/"+ index)



