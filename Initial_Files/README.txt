Names:

xx_yyy_z

x: dataset type

	ri = right iris

	rt = right thumb

y: level

z: type

	(Null) = the main feature matrix, rows are each input instance, columns are the neurons output

	mean = mean value of the columns of the feature matrix, i.e. mean value of each neuron's output

	bin = main features binarized based on the mean of each column

	check = the consistensy factor of each column (neuron), defined as the number of chunks with the length
	of five that have more than one inconsistency inside them, calculated by partitioning column into 165
	parts, each part for one user, and summing the output of the selected neuron in that part. If the summation
	is equal to 2 or 3, there is an inconsistency for that user in that neuron, and "1" gets added to the value
	of check. Doing so for all users (partitions), will result in the number of times this neuron has had inconsistencies
	which can vary between 0 to 165

	index = contains the indices of the neurons that have high consistency, is calculated by thresholding the check
	matrix and finding the place for the neurons that have low check value. ***Indices in python start from 0 and go to (n-1)

	bin_pruned = the final features, binarized and pruned based on the index matrix. Those neurons who are inside the index are kept,
	the rest are discarded
	
	details = some key thresholds and value that can be later used to redo the simulation faster, might not necessarily be useful

How to find the suitable neurons for mask:
	A suitable neuron is a consistent neuron. The consistency of each neuron is measured and saved in the check array. If one
	chooses the ones with lower check value, they can create a more robust mask concerning errors in neurons' output. The
	chosen neurons will ofcourse be in the index array, but it is a good idea to choose only the handful of them that have high
	consistency.
	

