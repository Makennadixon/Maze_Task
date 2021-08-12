%% Makenna Maze Generation Algorithm
clear; clc;
makenna_folder = '';
devin_folder = 'C:\Users\austid\OneDrive - University of Delaware - o365\Documents\GitHub\Maze_Task';
duncan_folder = '/Users/duncan/Documents/GitHub/Maze_Task';
cd(devin_folder); 

hold on
cla()
ax = gca();
%% Set Maze Paremeters

%Number of turns
num_turns = 5;
%total path length
path_length = 10;
% Size of grid 
grid_size = 10;

%% Create  and Plot grid
%Create an "x" by "x" grid
xgrid = 0:1:grid_size;
ygrid = 0:1:grid_size;
% display 10 by 10 grid
xl = arrayfun(@(x)xline(x,'k', "LineWidth",2), xgrid);
yl = arrayfun(@(y)yline(y,'k','LineWidth',2), ygrid);

%% Create and Plot Start Location

% randomize x and y coordinates of start location
% variable a cooralates with x-coordinate
% min 1 and max grid_size - 1
x_start = randi([1 grid_size-1]);
% varaible b coralates with y-coordinate
y_start = randi([1 grid_size-1]);
% x and y coordinates of the start location
start_current_position = [x_start y_start];

% plot green start location on grid
ml = arrayfun(@(x)xline(x,'k', "LineWidth",2),xgrid); (rectangle('Position',[x_start,y_start,1,1],'FaceColor','g'));
nl = arrayfun(@(y)yline(y,'k','LineWidth',2),ygrid,'UniformOutput', false); (rectangle('Position',[x_start,y_start,1,1],'FaceColor','g'));

%% Direction types & randomize directions

%Direction types
% These variables are not used within the code
% They are reference to what the direction types are
N = [0,1]; % north
E = [1,0]; % east
S = [0,-1]; % south
W = [-1,0]; % west

% values in datasample
% 1 -> north
% 2 -> east
% 3 -> south
% 4 -> west

% This if statement starts the path of maze based off
% of the starting grid location

% when the x, y coordinates are on the bounds of the grid
% Then it can only go a certain direction

if (x_start == 9 && y_start == 9)
% uses datasample to randomize direction types based on where the path can
% contiune on to next
rand_dirc = datasample([1 2 3 4],1,"Weights",[0, 0, 0.50, 0.50]);
elseif x_start == 0 % in bottom row
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.33, 0.33, 0.33, 0]);
elseif y_start == 0 % in top row
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.33, 0.33, 0, 0.33]);
elseif x_start == 0 && y_start == 0
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.50, 0.50, 0, 0]);
elseif x_start == 9 % in 1st row
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.33, 0, 0.33, 0.33]);
elseif y_start == 9 % in last row
rand_dirc = datasample([1 2 3 4],1,"Weights",[0, 0.33, 0.33, 0.33]);
elseif x_start == 9 && y_start == 0 % 
rand_dirc = datasameple([1 2 3 4],1,"Weights",[.50, 0, 0, 0.50]);
elseif x_start == 0 && y_start == 9 % 
rand_dirc = datasample([1 2 3 4],1,"Weights",[0, 0.50, 0.50, 0]);
% When the start location is not on the outer bounds
% can equally randomize the direction of the start grid path
elseif x_start ~= 9 || x_start~= 0 && y_start ~= 9 || y_start ~= 0 
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25, 0.25, 0.25, 0.25]);
end

% North
if rand_dirc == 1
new = [x_start+0, y_start+1];
% East
elseif rand_dirc == 2
new = [x_start+1, y_start+0];
% South
elseif rand_dirc == 3
new = [x_start+0, y_start-1];
% west
elseif rand_dirc == 4
new = [x_start-1, y_start+0];
end
% Assign new variable to "new"
new_scpos = new;

%Create the starting maze path on the grid
% which is blue
path = rectangle('Position',[new_scpos,1,1], 'FaceColor','b');
hold on
% assign new varible 'p' to current x,y coordinates
p = new_scpos;


%% Create path

%The total number of segment lengths
Max_lengths = num_turns+1;

% c = create an array of value whose length depends on the number
% of turns and elements depend on the path length
c = (diff([0,sort(randi([0,path_length-Max_lengths],1,Max_lengths-1)),path_length-Max_lengths])+ones(1,Max_lengths));


% assign new varible to p
% in order to update the new coordinates of maze path
new_path_dirc = p;
% update the value of p from startiing grid path location
p = new_scpos;
% iterate through the length of c
for i = 1:length(c)
% analyze each individual element of 'c' array
for ii = 1:c(i)
% When the individual element of 'c' is greater than one
% create the path, WHEN ITS NOT A TURN
if c(i) > 1

%update the value of variable of p
p = new_path_dirc;

% substract that individual element by one
c(i) = c(i) - 1;

% p(1) -> x coordinate of maze path
% p(2) -> y coordinate of maze path
% new_path_dirc -> new x,y coordinates used to create the maze on grid

is_new_path_good = false;
while (is_new_path_good == false)
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25, 0.25, 0.25, 0.25]);
% create path in north direction
if rand_dirc == 1
new_path_dirc = [p(1)+0, p(2)+1];
end
% create path in east direction
if rand_dirc == 2
new_path_dirc = [p(1)+1, p(2)+0];
end
% create path in south direction
if rand_dirc == 3
new_path_dirc = [p(1)+0, p(2)-1];
end
% create path in west direction
if rand_dirc == 4
new_path_dirc = [p(1)-1, p(2)+0];
end
if (new_path_dirc(1) < 0 || new_path_dirc(1) > 9 || new_path_dirc(2) < 0 || new_path_dirc(2) > 9)
    is_new_path_good = false;
else
    is_new_path_good = true;
end
    
end

% create maze path on the grid
rectangle('Position',[new_path_dirc,1,1], 'FaceColor','b');
end

% When the element in array c is 1 and not the last segment
% Craete a TURN
if c(i) == 1 && i ~= Max_lengths
% decrease the elements in array c by one
c(i) = c(i) - 1;
% update the value of p
p = new_path_dirc;

% change direction E W
% when direction of path is either going north or south

% new_path_dirc(1) -> x coordinate of maze path @ turn
% new_path_dirc(2) -> y coordinate of maze path @ turn
% new_path-dirc2 -> new x, y coordinates of maze path @ turn

if rand_dirc == 1 || rand_dirc == 3
% randomly chooses between going east or west
dirc = datasample([1 2 3 4],1,"Weights",[0 0.50 0 0.50]);
if dirc == 2 % east
new_path_dirc2 = [new_path_dirc(1)+1, new_path_dirc(2)+0];
elseif dirc == 4 % west
new_path_dirc2 = [new_path_dirc(1)-1, new_path_dirc(2)+0];
end
% update the value of varibale p (coordiantes of the path)
p = new_path_dirc2;
% update the value of variable rand-dirc (path direction of the maze)
rand_dirc = dirc;
% update the value of variable new_path_dirc
new_path_dirc = p;

% change direction N S
% when direction of path is either going east or west
elseif rand_dirc == 2 || rand_dirc == 4
% randomly choose between going north or south
dirc = datasample([1 2 3 4],1,"Weights",[0.50 0 0.50 0]);
if dirc == 1 % north
new_path_dirc2 = [new_path_dirc(1)+0, new_path_dirc(2)+1];
elseif dirc == 3 % south
new_path_dirc2 = [new_path_dirc(1)+0, new_path_dirc(2)-1];
end
% update the value of variable p (coordiantes of the path)
p = new_path_dirc2;
% update the value of variable rand_dirc (path direction of the maze)
rand_dirc = dirc;
% update the value of variable new_path_dirc
new_path_dirc = p;
end

% When the path is on the outer bounds of grid
% choose new direction to go to stay within the bounds of the grid
% WHEN AT A TURN
while new_path_dirc2(1) < 0 || new_path_dirc2(1) > 9 || new_path_dirc2(2) < 0 || new_path_dirc2(2) > 9
rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25, 0.25, 0.25, 0.25]);

%change direction E W
% when direction of path is either going north or south

% update the value of variable of p
p = new_path_dirc;
if rand_dirc == 1 || rand_dirc == 3
% randomly choose between going east or west
dirc = datasample([1 2 3 4],1,"Weights",[0 0.50 0 0.50]);
if dirc == 2 % east
new_path_dirc2 = [new_path_dirc(1)+1, new_path_dirc(2)+0];
elseif dirc == 4 % west
new_path_dirc2 = [new_path_dirc(1)-1, new_path_dirc(2)+0];
end
% update the value of variable p (coordiantes of the path)
p = new_path_dirc2;
% update the value of variable rand_dirc (path direction of maze)
rand_dirc = dirc;
% update the value of variable new_path_dirc
new_path_dirc = p;

% change direction N S
% when direction of path is either going east or west
elseif rand_dirc == 2 || rand_dirc == 4
% randomly choose between going north or south
dirc = datasample([1 2 3 4],1,"Weights",[0.50 0 0.50 0]);
if dirc == 1 % north
new_path_dirc2 = [new_path_dirc(1)+0, new_path_dirc(2)+1];
elseif dirc == 3 % south
new_path_dirc2 = [new_path_dirc(1)+0, new_path_dirc(2)-1];
end
% update the value of variable p (coordiantes of the path)
p = new_path_dirc2;
% update the value of variable rand_dirc (path direction of maze)
rand_dirc = dirc;
% update the value of variable new_path_dirc
new_path_dirc = p;
end

end
% creates the path of maze on the grid
rectangle('Position',[new_path_dirc2,1,1], 'FaceColor','b')

end


end
end


% create the finish grid area
% This at the movement is seperate from the for loop of the path
% therefore will go off thr grid

% update the value of variable new_path_dirc
new_path_dirc2 = new_path_dirc;

if rand_dirc == 1 %north
finish_location = [new_path_dirc2(1)+0, new_path_dirc2(2)+1];
rectangle('Position',[finish_location,1,1], 'FaceColor',[0.5 0.5 0.5]);
elseif rand_dirc == 2 % east
finish_location = [new_path_dirc2(1)+1, new_path_dirc2(2)+0];
rectangle('Position',[finish_location,1,1], 'FaceColor',[0.5 0.5 0.5]);
elseif rand_dirc == 3 % west
finish_location = [new_path_dirc2(1)+0, new_path_dirc2(2)-1];
rectangle('Position',[finish_location,1,1], 'FaceColor',[0.5 0.5 0.5]);
elseif rand_dirc == 4 % south
finish_location = [new_path_dirc2(1)-1, new_path_dirc2(2)+0];
rectangle('Position',[finish_location,1,1], 'FaceColor',[0.5 0.5 0.5]);
end   
