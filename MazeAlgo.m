%% Makenna Maze Generation Algorithm and Example
clear; clc; 
% makenna_folder = '';
% devin_folder = '';
duncan_folder = '/Users/duncan/Documents/GitHub/Maze_Task';
% 
cd(duncan_folder); 

%% Call function 

number_of_turns = 5;
length_of_path = 10;
gridX = 10; gridY = 10;
maxIter = 100; 

num_runs = 5; % use to make sure works all the time 

for i = 1:num_runs
    genMaze(number_of_turns, length_of_path, gridX, gridY, maxIter); 
end

%% Function 

function genMaze(num_turns, path_length, gridX, gridY, maxIter)
%{
Generate random maze 

INPUTS:
num_turns: # of turns 
path_length: # of blocks / spaces to travel 
gridX: x maximum 
gridY: y maximum 
maxIter: maximum number of iterations 

OUTPUT:
Visualization of random maze 
%}

%% Check arguments 
arguments 
    num_turns (1,1) {mustBePositive, mustBeFinite, mustBeReal, ...
        mustBeInteger, mustBeNumeric, mustBeNonempty}
    path_length (1,1) {mustBePositive, mustBeFinite, mustBeReal, ...
        mustBeInteger, mustBeNumeric, mustBeNonempty}
    gridX (1,1) {mustBePositive, mustBeFinite, mustBeReal, ...
        mustBeInteger, mustBeNumeric, mustBeNonempty}
    gridY (1,1) {mustBePositive, mustBeFinite, mustBeReal, ...
        mustBeInteger, mustBeNumeric, mustBeNonempty}
    maxIter (1,1) {mustBePositive, mustBeFinite, mustBeReal, ...
        mustBeInteger, mustBeNumeric, mustBeNonempty}
end

%% Create grid

% Create a 10 by 10 grid
xgrid = 0:1:gridX;
ygrid = 0:1:gridY;

% Initiate random start location 
startX = randi([1 gridX-1]); 
startY = randi([1 gridY-1]); 
start_current_position = [startX, startY]; 

% display 10 by 10 grid
figure(); 
arrayfun(@(x)xline(x,'k', "LineWidth",2), xgrid);
arrayfun(@(y)yline(y,'k','LineWidth',2), ygrid);
hold on
% display green start location on grid
arrayfun(@(x)xline(x,'k', "LineWidth",2),xgrid), ...
    (rectangle('Position',[startX,startY,1,1],'FaceColor','g'));

arrayfun(@(y)yline(y,'k','LineWidth',2),ygrid,'UniformOutput', false), ...
    (rectangle('Position',[startX,startY,1,1],'FaceColor','g'));

maze_position = start_current_position; 

%% Direction types & randomize directions

% 1 -> north
% 2 -> east
% 3 -> south
% 4 -> west

% Direction types
N = [0,1];
E = [1,0];
S = [0,-1];
W = [-1,0];

% This if statement starts the path of maze based off of the starting grid location

% when the x, y coordinates are on the bounds of the grid
% Then it can only go a certain direction

% all these should have 2 (x,y) statements otherwise they may get overwritten 
if startX == 9 && startY == 9
    w = [0, 0, 0.50, 0.50]; 
    
elseif startX == 0 
    w = [0.33, 0.33, 0.33, 0];
    
elseif startY == 0
    w = [0.33, 0.33, 0, 0.33];
    
elseif startX == 0 && startY == 0
    w = [0.50, 0.50, 0, 0];
    
elseif startX == 9
    w = [0.33, 0, 0.33, 0.33];
    
elseif startY == 9
    w = [0, 0.33, 0.33, 0.33];
    
elseif startX == 9 && startY == 0
    w = [0, 0, 0.50, 0.50];
    
elseif startX == 0 && startY == 9
    w = [0, 0.50, 0.50, 0];
    
elseif startX ~= 9 || startX ~= 0 && ...
        startY ~= 9 || startY ~= 0
    % When the start location is not on the outer bounds
    % can equally randomize the direction of the start grid path
    w = [0.25, 0.25, 0.25, 0.25];
    
end

% Use datasample to randomize direction types based on where the path can
% contiune on to next
rand_dirc = random_choice([1 2 3 4], w); 
% rand_dirc = datasample([1 2 3 4],1,"Weights",w);

if rand_dirc == 1 % North
    new = start_current_position + N; 
elseif rand_dirc == 2 % East
    new = start_current_position + E; 
elseif rand_dirc == 3 % South
    new = start_current_position + S; 
elseif rand_dirc == 4 % west
    new = start_current_position + W; 
end

% maze positions 
maze_position = [maze_position; new]; 

% Create the starting maze block (blue) on the grid
rectangle('Position',[new,1,1], 'FaceColor','b');

% assign new varible 'p' to current x,y coordinates
p = new;

%% Create path

%The total number of segment lengths
Max_lengths = num_turns+1;

%{
Paragraph about what is happening here please 
%}
c = (diff([0,sort(randi([0,path_length-Max_lengths],1,num_turns)),path_length-Max_lengths])+ones(1,Max_lengths));

% in order to update the new coordinates of maze path
new_path_dirc = p;
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

            is_new_path_good = false; currentIter = 1;
            while (is_new_path_good == false)
                rand_dirc = random_choice([1 2 3 4], [0.25 0.25 0.25 0.25]); 
%                 rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25, 0.25, 0.25, 0.25]);
                % create path in north direction
                if rand_dirc == 1
                    new_path_dirc = p + N;
                end
                % create path in east direction
                if rand_dirc == 2
                    new_path_dirc = p + E;
                end
                % create path in south direction
                if rand_dirc == 3
                    new_path_dirc = p + S;
                end
                % create path in west direction
                if rand_dirc == 4
                    new_path_dirc = p + W;
                end
                if (new_path_dirc(1) < 0 || new_path_dirc(1) > 9 || ...
                        new_path_dirc(2) < 0 || new_path_dirc(2) > 9) || ...
                        sum(sum(new_path_dirc == maze_position, 2) == 2) >0
                    is_new_path_good = false;
                else
                    is_new_path_good = true;
                end
                if currentIter == maxIter
                    fprintf('Algorithm did not converge. Try again.\n')
                    return
                end
                currentIter = currentIter +1; 
            end

        maze_position = [maze_position; new_path_dirc]; 
        % create maze path on the grid
        rectangle('Position',[new_path_dirc,1,1], 'FaceColor','b');
        end

        % When the element in array c is 1 and not the last segment
        % Create a TURN
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
            is_new_path_good = false; currentIter = 1;
            while (is_new_path_good == false)
                rand_dirc = random_choice([1 2 3 4], [0.25 0.25 0.25 0.25]); 
%                 rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25 0.25 0.25 0.25]);

                if rand_dirc == 1 || rand_dirc == 3
                    % randomly chooses between going east or west
                    dirc = random_choice([1 2 3 4], [0 0.50 0 0.50]); 
%                     dirc = datasample([1 2 3 4],1,"Weights",[0 0.50 0 0.50]);
                    if dirc == 2 % east
                        new_path_dirc2 = new_path_dirc + E;
                    elseif dirc == 4 % west
                        new_path_dirc2 = new_path_dirc + W;
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
                    dirc = random_choice([1 2 3 4], [0.50 0 0.50 0]); 
%                     dirc = datasample([1 2 3 4],1,"Weights",[0.50 0 0.50 0]);
                    if dirc == 1 % north
                        new_path_dirc2 = new_path_dirc + N;
                    elseif dirc == 3 % south
                        new_path_dirc2 = new_path_dirc + S;
                    end
                    % update the value of variable p (coordiantes of the path)
                    p = new_path_dirc2;
                    % update the value of variable rand_dirc (path direction of the maze)
                    rand_dirc = dirc;
                    % update the value of variable new_path_dirc
                    new_path_dirc = p;
                end
                if (new_path_dirc2(1) < 0 || new_path_dirc2(1) > 9 ||...
                        new_path_dirc2(2) < 0 || new_path_dirc2(2) > 9) || ...
                        sum(sum(new_path_dirc2 == maze_position, 2) == 2) >0
                    is_new_path_good = false;
                else
                    is_new_path_good = true;
                end
                if currentIter == maxIter
                    fprintf('Algorithm did not converge. Try again.\n')
                    return
                end
                currentIter = currentIter +1; 
            end
            maze_position = [maze_position; new_path_dirc2]; 
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
is_new_path_good = false; currentIter = 1;
while (is_new_path_good == false)
    rand_dirc = random_choice([1 2 3 4], [0.25 0.25 0.25 0.25]); 
%     rand_dirc = datasample([1 2 3 4],1,"Weights",[0.25 0.25 0.25 0.25]);
    if rand_dirc == 1 % north
        finish_location = new_path_dirc2 + N; 
    elseif rand_dirc == 2 % east
        finish_location = new_path_dirc2 + E;
    elseif rand_dirc == 3 % west
        finish_location = new_path_dirc2 + W; 
    elseif rand_dirc == 4 % south
        finish_location = new_path_dirc2 + S; 
    end
    if (finish_location(1) < 0 || finish_location(1) > 9 ||...
            finish_location(2) < 0 || finish_location(2) > 9) || ...
            sum(sum(finish_location == maze_position, 2) == 2) >0
        is_new_path_good = false;
    else
        is_new_path_good = true;
    end
    if currentIter == maxIter
        fprintf('Algorithm did not converge. Try again.\n')
        return
    end
    currentIter = currentIter +1; 
end
maze_position = [maze_position; finish_location]; 
rectangle('Position',[finish_location,1,1], 'FaceColor',[0.5 0.5 0.5]);
    
end

function choice = random_choice(array, w)
%{
Randomly choose 1 value from array with weights w (pseudo-uniform)

INPUTS:
array: array of values [N X 1]
w: weights [N X 1]

OUTPUT:
choice: element from array 
%}

arguments 
    array (:,1)
    w (:,1)
end

if length(array) ~= length(w)
    error('Elements of array and w must have same lengths')
end

choices = array(w ~= 0);

rnd = randi([1 length(choices)], 1);

choice = choices(rnd); 

end
