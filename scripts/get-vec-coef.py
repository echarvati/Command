import argparse

parser = argparse.ArgumentParser(description='This is a code to get coefficients of VES method easy to plot')
parser.add_argument('-i', '--input', type=str, help='The output coeffs.data file of PLUMED')
opt = parser.parse_args()

time_list = []
coef_list = []
for line in open(opt.input, 'r').readlines():
    if line.startswith('#! SET time'):
        time_list.append(line.split()[-1])
    elif not line.startswith('#'):
        info = line.split()
        coef_id = int(info[-1])
        if len(coef_list) < coef_id + 1:
            coef_list.append([])
        coef_list[coef_id].append(info[-3])

f = open('coefs.txt', 'w')
for i, time in enumerate(time_list):
    f.write('%s ' % time)
    for coefs in coef_list:
        f.write('%s ' % coefs[i])
    f.write('\n')
f.close()
