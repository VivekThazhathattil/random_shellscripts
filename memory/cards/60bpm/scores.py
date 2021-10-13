from matplotlib import pyplot as plt
scores = [2, 0, 2, 2, 2, 2, 2, 4, 1, 1,]
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
