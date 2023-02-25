%calculating the PMFs of empirical, RH, and binomial distributions of all possible tuples in a random dataset with given AVFM

%%simulation setting
clear
ntest=1e3;%number of randomized experiments for calculation experience distribution, the value can be set to le8
nround=10;%number of randomized experiment rounds. Due to the limitation of computing and storage resources, the experiment needs to be carried out in multiple rounds
N=100;%number of records
d=4;%number of attributes
lambda_0=0.5;%a lambda preset value that is close to, but usually not equal to, the true value
[AVFM,lambda]=genAVFM(N,d,lambda_0); %Generating AVFM based on N, d,lambda

%%generating a random dataset. only an example, you can erase the following code.
stdset_test=genstdset(AVFM); %generating standard dataset based on AVFM
dataset_test=gendataset(stdset_test); %generating random dataset based on standard dataset

%%calculating
get3TFPs;

%%ploting the PMFs of 3 distributions of a tuple with the JS vlue
plot3TFPs;

