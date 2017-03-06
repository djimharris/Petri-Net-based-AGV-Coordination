% disp('Enter the number of places');
% pLimit = input('Enter the number of places: ');
% tLimit = input('Enter the number of transitions: ');

% %Places contain input transitions and output transitions.

% for i = 1:p
% 	disp('Input for place ',i,':');
% 	disp('------------------------------------------');
% 	disp{' '};
% 	p(i).tInLimit = input('Number of input transitions: ');
% 	p(i).tOutLimit = input('Number of output transitions: ');

% 	disp('Enter the input transitions - ');
% 	disp(' ');

% 	for j = 1:tInLimit
% 		disp('Input transition ',j,' for place ',i,': ');
% 		p(i).tIn(j) = input();
% 	end

% 	disp('Enter the output transitions - ');
% 	disp(' ');

% 	for j = 1:tOutLimit
% 		disp('Output transition ',j,' for place ',i,': ');
% 		p(i).tOut(j) = input();
% 	end
% 	disp('Entry for place ',i,' complete.');
% end

% markingFlag = 0;
% while markingFlag = 0
% 	m0 = input('Initial marking: ');
% 	if cols(m0)~=pLimit
% 		disp('Not the right number of places.');
% 	else
% 		flag = 1;
% 	end
% end

% %Input transitions

% disp(' ');
% disp('Transition Input');
% disp('--------------------------------------------------------------------------------');
% for i = 1:tLimit
% 	disp('Transition ',i,': ')
% 	transition(i) = input('');
% end
% node(1,1).marking = m0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CHANGE IN MODEL: A class exists for transitions which contains the requirement marking for the transition, and the modification the transition makes.

disp('Enter the number of places');
pLimit = input('Enter the number of places: ');
tLimit = input('Enter the number of transitions: ');

markingFlag = 0;
while markingFlag == 0
	m0 = input('Initial marking: ');
	if size(m0,2)~=pLimit
		disp('Not the right number of places.');
	else
		markingFlag = 1;
	end
end

disp('Entering properties for each transition -');
disp('--------------------------------------------------------------------------------------');
disp('');

for i = 1:tLimit
	transition(i).requirement = zeros(pLimit);
	transition(i).change = zeros(pLimit);
	disp('Transition ',i,':');
	tIn = input('Places transitioning from: ');

	for j = 1:size(tIn,2)
		transition(i).requirement(tIn(j)) = transition(i).requirement(tIn(j)) + 1;
	end

	tOut = input('Places transitioning to: ');

	for j = 1:size(tOut,2)
		transition(i).change(tIn(j)) = transition(i).change(tIn(j)) + 1;
	end
end

node(1,1).marking = m0;
% node(1,1).children = []; 										% Contains possible transition number
% node(1,1).transitionedFrom = []; 								% Removee this; single element only, and top node has no transitions

transitionChildrenCount = 0; 									% Counter for keeping track of the number of children each node has
for i = 1:tLimit
	if sum(node(1,1).marking>=transition(i).requirement) == size(node(1,1).marking>=transition(i).requirement,2) % sum(a>=b) == size(a>=b,2) | Checking if the previous marking is large enough for the transition we're looking into
		transitionChildrenCount = transitionChildrenCount + 1;	% Increase the children count by 1
		node(1,1).children(transitionChildrenCount) = i;		% Store the transition's number into the children array
		node(1,1).childNodes(transitionChildrenCount) = transitionChildrenCount;
	end
end

lastNodeAtLevel(1) = 1;											% Well, obviously
lastNodeAtLevel(2) = transitionChildrenCount;					% To keep track of the last node at the next level; here, it's the number of children from the previous level.
nodeCount = 1;													% Counter for traversing through the next level
for i = 1:transitionChildrenCount								% Inserting markings for next level
	node(2,nodeCount).marking = node(1,1).marking + transition(node(1,1).children(i)).change;
	node(2,nodeCount).transitionedFrom = node(1,1).children(i);
	node(2,nodeCount).parent = 1;
	nodeCount = nodeCount + 1;
end

% NOTE: treeEndFlag takes 1 when hitting the end of a tree or when going into an indefinite tree, check for null markings at nodes to end it there.
% NOTE: Have a total count of nodes at every level. Or look for the last node. 
i = 2;
treeEndFlag = 0;
nodesNotSimilar = 0;
while (treeEndFlag == 0) & (lastNodeAtLevel(i) ~= 0) & (nodesNotSimilar ~= 0)				% Checking if there are any nodes for the next level
	nodeCount = 1;
	for j = 1:lastNodeAtLevel(i)
		if size(node(i,j).marking, 2) >= 1													% Checking if the node has content or not through the size of the marking
			transitionChildrenCount = 0; 
			for k = 1:tLimit
				if sum(node(i,j).marking>=transition(k).requirement) == size(node(i,j).marking>=transition(k).requirement,2)
					transitionChildrenCount = transitionChildrenCount + 1;					% Increase the children count by 1
					node(i,j).children(transitionChildrenCount) = k;
					node(i,j).childNodes(transitionChildrenCount) = nodeCount + transitionChildrenCount;
				end
			end

			for childrenCounter = 1:transitionChildrenCount
				node(i+1,nodeCount).marking = node(i,j).marking + transition(node(i,j).children(childrenCounter)).change;
				node(i+1,nodeCount).transitionedFrom = node(i,j).children(childrenCounter);
				node(i+1,nodeCount).parent = j;
				nodeCount = nodeCount + 1;
			end
		end
	end
	lastNodeAtLevel(i+1) = nodeCount - 1;

	% Roll through markings in this node and the next node to see if they are the same

	nodesNotSimilar = 0;
	if lastNodeAtLevel(i) ~= lastNodeAtLevel(i+1)
		nodesNotSimilar = 1;
	else
		for k = 1:lastNodeAtLevel
			if sum(node(i,k).marking==node(i+1,k).marking) ~= size(node(i,k).marking==node(i+1,k).marking)
				nodesNotSimilar = 1;
			end
		end
	end
	i = i + 1;
end