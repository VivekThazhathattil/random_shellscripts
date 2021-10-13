from matplotlib import pyplot as plt
scores = [2, 3, 8, 6, 2, 4, 0, 16, 2, 2,
        12, 5, 5, 16, 10, 11, 1, 9, 15, 5,
        12, 7, 1, 12, 17, 24, 0, 7, 17, 20, 
        10, 8, 10, 9, 0, 10, 6, 0, 8, 12, 
        12, 6, 4, 3, 6, 14, 12, 0, 6, 7,
        0, 23, 18, 12, 10, 13, 7, ]
avg = round(sum(scores)/len(scores),2)
cum_avg = []
sum_ = 0
for i in range(len(scores)):
    sum_ += scores[i]
    cum_avg.append(sum_/(i+1))

print("Latest: " + str(scores[-1]))
print("Average: " + str(avg))
print("Number of tries: " + str(len(scores)))
print("High score: " + str(max(scores)))
plt.scatter([i for i in range(len(scores))], scores)
plt.plot(scores)
plt.plot(cum_avg)
plt.legend(["Latest score (" + str(scores[-1]) + ")", "Average score (" + str(avg) + ") \n # of tries: " + str(len(scores)) + "\n High score: " + str(max(scores))])
plt.grid();
plt.show()
