function graph = graph_generate()

% Graph is used to represent the various paths available to the AGVs
% % It consists of various structures
% Each element consists of the following variables:
% connect_no to indicate the number of connections to that particular node
% connect is a matrix which states the other nodes to which the particular element is connected to
% value is used to indicate the presence or absence of an object
% index is used to represent the node by a single number

graph(1,1).index=11;
graph(1,1).connect=[2 1];
graph(1,1).connect_no=1;

graph(1,2).index=12;
graph(1,2).connect=[2 2];
graph(1,2).connect_no=1;

graph(1,3).index=13;
graph(1,3).connect=[2 3];
graph(1,3).connect_no=1;

graph(2,1).index=21;
graph(2,1).connect=[1 1;2 2;3 1];
graph(2,1).connect_no=3;

graph(2,2).index=22;
graph(2,2).connect=[2 1;1 2;3 2;2 3];
graph(2,2).connect_no=4;

graph(2,3).index=23;
graph(2,3).connect=[2 2;1 3;3 3];
graph(2,3).connect_no=3;

graph(3,1).index=31;
graph(3,1).connect=[2 1;4 1;3 2];
graph(3,1).connect_no=3;

graph(3,2).index=32;
graph(3,2).connect=[2 2;3 1;3 3;4 2];
graph(3,2).connect_no=4;

graph(3,3).index=33;
graph(3,3).connect=[2 3;4 3;3 2];
graph(3,3).connect_no=3;

graph(4,1).index=41;
graph(4,1).connect=[3 1;4 2;5 1];
graph(4,1).connect_no=3;

graph(4,2).index=42;
graph(4,2).connect=[3 2;4 1;4 3;5 2];
graph(4,2).connect_no=4;

graph(4,3).index=43;
graph(4,3).connect=[3 3;4 2;5 3];
graph(4,3).connect_no=3;

graph(5,1).index=51;
graph(5,1).connect=[4 1];
graph(5,1).connect_no=1;

graph(5,2).index=52;
graph(5,2).connect=[4 2];
graph(5,2).connect_no=1;

graph(5,3).index=53;
graph(5,3).connect=[4 3];
graph(5,3).connect_no=1;




%BACKUP
% graph(1,1).index=11;
% graph(1,1).connect=[2 1];
% graph(1,1).connect_no=1;

% graph(1,2).index=12;
% graph(1,2).connect=[2 2];
% graph(1,2).connect_no=1;

% graph(1,3).index=13;
% graph(1,3).connect=[2 3];
% graph(1,3).connect_no=1;

% graph(2,1).index=21;
% graph(2,1).connect=[1 1;2 2;3 1];
% graph(2,1).connect_no=3;

% graph(2,2).index=22;
% graph(2,2).connect=[2 1;1 2;3 2;2 3];
% graph(2,2).connect_no=4;

% graph(2,3).index=23;
% graph(2,3).connect=[2 2;1 3;3 3];
% graph(2,3).connect_no=3;

% graph(3,1).index=31;
% graph(3,1).connect=[2 1;4 1;3 2];
% graph(3,1).connect_no=3;

% graph(3,2).index=32;
% graph(3,2).connect=[2 2;3 1;3 3;4 2];
% graph(3,2).connect_no=4;

% graph(3,3).index=33;
% graph(3,3).connect=[2 3;4 3;3 2];
% graph(3,3).connect_no=3;

% graph(4,1).index=41;
% graph(4,1).connect=[3 1];
% graph(4,1).connect_no=1;

% graph(4,2).index=42;
% graph(4,2).connect=[3 2];
% graph(4,2).connect_no=1;

% graph(4,3).index=43;
% graph(4,3).connect=[3 3];
% graph(4,3).connect_no=1;
%BACKUPEND