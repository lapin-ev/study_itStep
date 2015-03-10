//
// Created by Jack Lapin on 12.02.15.
// Copyright (c) 2015 JackLapin. All rights reserved.
//


#import "AStar.h"

@implementation AStar
{
    ASnode *_startPoint;
    ASnode *_finishPoint;
    NSArray *_grid;
    NSMutableArray *_obstacles;

    NSUInteger _width;
    NSUInteger _height;

    //Declare constants
    int mapWidth;
    int mapHeight ;
    int tileSize ;
    int numberPeople ;
    id onClosedList ;
    int notfinished ;
    int notStarted ;// path-related constants
    int found ;
    int nonexistent ;
    int walkable ;
    int unwalkable ;// walkability array constants

    //Create needed arrays
    NSMutableArray * walkability; // 2d array
    NSMutableArray * openList; //1 dimensional array holding ID# of open list items
    NSMutableArray * whichList;  //2 dimensional array used to record
// 		whether a cell is on the open list or on the closed list.
    NSMutableArray * openX; //1d array stores the x location of an item on the open list
    NSMutableArray * openY; //1d array stores the y location of an item on the open list
    NSMutableArray * parentX; //2d array to store parent of each cell (x)
    NSMutableArray * parentY; //2d array to store parent of each cell (y)
    NSMutableArray * Fcost;	//1d array to store F cost of a cell on the open list
    NSMutableArray * Gcost; 	//2d array to store G cost for each cell.
    NSMutableArray * Hcost;	//1d array to store H cost of a cell on the open list
    NSMutableArray * pathLength;     //stores length of the found path for critter
    NSMutableArray * pathLocation;   //stores current position along the chosen path for critter
    NSMutableArray* pathBank;

    NSMutableArray * pathStatus;
    NSMutableArray * xPath;
    NSMutableArray * yPath;

}

/*
 * static
 */

- (NSUInteger)manhattanHeuristic:(ASnode *)gridCell destinationNode:(ASnode *)destinationNode cost:(NSUInteger)cost
{
    NSUInteger result;
    result = (abs((int) gridCell.point.x - (int) destinationNode.point.x) + abs((int) gridCell.point.y - (int) destinationNode.point.y)) * cost;
    return result;
}

//todo:review signature
- (NSMutableArray *)_connectedNodes:(CGPoint)position
{
    NSMutableArray *result = [[NSMutableArray alloc] init];

    ASnode *currentNode = _grid[(int)position.x][(int)position.y];

    for (NSInteger x = (NSInteger) position.x - 1; x <= position.x + 1; x++)
    {
        for (NSInteger y = (NSInteger) position.y - 1; y <= position.y + 1; y++)
        {
            BOOL isCurrentNode = x == position.x && y == position.y;

            //todo: invert and improve
            if (x > _height || x < 0 || y > _width || y < 0 || isCurrentNode)
            {
                continue;
            }
            else
            {
                ASnode *neighbour = _grid[x][y];

                [neighbour setParent:currentNode];
                [neighbour setH:[self manhattanHeuristic:neighbour destinationNode:_finishPoint cost:10]];

                if (x == (NSInteger)position.x || y == (NSInteger)position.y)
                {

                    //   direct way
                    NSLog(@"direct way");
                }
                else
                {
                    //   diagonal way
                }

                [result addObject:neighbour];
            }

            if (_obstacles.count > 0)
            {
                //todo: analize obstacles
            }

        }

    }

    return result;
}


/*
 * methods
 */

- (id)initWithGrid:(NSUInteger)width height:(NSUInteger)height
{
    self = [super init];


    if (self != nil)
    {
        _width = width;
        _height = height;

        [self _createGrid];

        mapWidth = 80;
        mapHeight = 60;
        tileSize = 10;
        numberPeople = 3;
        onClosedList = 10;
        notfinished = 0;
        notStarted = 0;// path-related constants
        found = 1;
        nonexistent = 2;
        walkable = 0;
        unwalkable = 1;// walkability array constants

        walkability  = [[NSMutableArray alloc] init]; // 2d array
        openList = [[NSMutableArray alloc] init]; //1 dimensional array holding ID# of open list items
        whichList = [[NSMutableArray alloc] init];  //2 dimensional array used to record
        openX = [[NSMutableArray alloc] init]; //1d array stores the x location of an item on the open list
        openY = [[NSMutableArray alloc] init]; //1d array stores the y location of an item on the open list
        parentX = [[NSMutableArray alloc] init]; //2d array to store parent of each cell (x)
        parentY = [[NSMutableArray alloc] init]; //2d array to store parent of each cell (y)
        Fcost = [[NSMutableArray alloc] init];	//1d array to store F cost of a cell on the open list
        Gcost = [[NSMutableArray alloc] init]; 	//2d array to store G cost for each cell.
        Hcost = [[NSMutableArray alloc] init];	//1d array to store H cost of a cell on the open list
        pathLength = [[NSMutableArray alloc] init];     //stores length of the found path for critter
        pathLocation = [[NSMutableArray alloc] init];   //stores current position along the chosen path for critter
        pathBank = [[NSMutableArray alloc] init];
        pathStatus = [[NSMutableArray alloc] init];
        xPath = [[NSMutableArray alloc] init];
        yPath = [[NSMutableArray alloc] init];


    }

    return self;
}

- (void)_createGrid
{
    NSMutableArray *rows = [NSMutableArray array];
    NSMutableArray *obstacle = [[NSMutableArray alloc] init];

    for (int i = 0; i < _height; i++)
    {
        NSMutableArray *row = [NSMutableArray array];

        for (int j = 0; j < _width; j++)
        {
            ASnode *node = [ASnode nodeWithPosition:CGPointMake(i, j)];
            [row addObject:node];
        }

        [rows addObject:row];
    }

    _grid = rows;
    _obstacles = obstacle;
}

- (void)print
{
    int startX = (int) _startPoint.point.x;
    int startY = (int) _startPoint.point.y;
    int finishX = (int) _finishPoint.point.x;
    int finishY = (int) _finishPoint.point.y;

    for (NSUInteger i = 0; i < _grid.count; i++)
    {
        NSString *string = @"";

        NSMutableArray *arrayRows = _grid[i];

        for (int j = 0; j < arrayRows.count; j++)
        {
            NSString *symbol;

            if ((startX == i && startY == j) || (finishX == i && finishY == j))
            {
                symbol = @"o ";
            }
            else
            {
                symbol = @"x ";
            }

            for (NSUInteger k = 0; k < _obstacles.count; k++)
            {
                ASnode *obs = _obstacles[k];

                if ((i == obs.point.x) && (j == obs.point.y))
                {
                    symbol = @"| ";
                }

            }

            string = [string stringByAppendingString:symbol];
        }

        NSLog(@"%@", string);
    }
}

- (void)setObstacle:(ASnode *)node
{
    NSAssert(_grid != nil, @"Grid not found");
    NSAssert(node.point.x <= _width && node.point.y <= _height, @"Obstacle %f , %f is out of range : %lu , %lu ", node.point.x, node.point.y, _width, _height);
    NSAssert(node.point.x != _startPoint.point.x && node.point.y != _startPoint.point.y, @"Obstacle and StartPoint at the same place");
    NSAssert(node.point.x != _finishPoint.point.x && node.point.y != _finishPoint.point.y, @"Obstacle and FinishPoint at the same place");

    if (_obstacles == nil)
    {
        _obstacles = [[NSMutableArray alloc] init];
    }

    for (NSUInteger i = 0; i < _obstacles.count; i++)
    {
        ASnode *existedObstacle = _obstacles[i];
        if ((node.point.x == existedObstacle.point.x) && (node.point.y == existedObstacle.point.y))
        {
            NSAssert(false, @"Obstacle %f , %f is already exist", node.point.x, node.point.y);
        }

    }

    ASnode *obstacle = [ASnode nodeWithPosition:node.point];
    [_obstacles addObject:obstacle];
}


- (ASnode *)findPath:(CGPoint)positionStart :(CGPoint)positionFinish
{
    ASnode *result = nil;

    NSMutableArray *openList = [[NSMutableArray alloc] init];
    NSMutableArray *closeList = [[NSMutableArray alloc] init];

    //todo:review
//    [openList addObject:positionStart];

//    while (currentNode != positionFinish)
//    {
    NSMutableArray *goingThroughNodes = [self _connectedNodes:positionStart];

    for (int i = 0; i<goingThroughNodes.count; i++)
    {
        NSLog(@"Neighbour %d", i);
        ASnode *aSnode = [[ASnode alloc] init];
        aSnode = [goingThroughNodes objectAtIndex:i];
    }

//    currentNode = positionFinish;
//    }

//    int i = [self manhattanHeuristic:positionStart destinationNode:positionFinish cost:10];
//    NSLog(@"%d", i);

   _startPoint = _grid[(int)positionStart.x][(int)positionStart.y];
   _finishPoint = _grid[(int)positionFinish.x][(int)positionFinish.y];

    return result;
}


-(int) FindPath : (int)pathfinderID : (int)startingX : (int)startingY : (int)targetX : (int) targetY

{
    int onOpenList=0, parentXval=0, parentYval=0,
            a=0, b=0, m=0, u=0, v=0, temp=0, corner=0, numberOfOpenListItems=0,
            addedGCost=0, tempGcost = 0, path = 0,
            tempx, pathX, pathY, cellPosition,
            newOpenListItemID=0;
            int tileSize = 1;
//1. Convert location data (in pixels) to coordinates in the walkability array.
    int startX = startingX/tileSize;
    int startY = startingY/tileSize;
    targetX = targetX/tileSize;
    targetY = targetY/tileSize;

//2.Quick Path Checks: Under the some circumstances no path needs to
//	be generated ...

//	If starting location and target are in the same location...
    if (startX == targetX && startY == targetY && pathLocation[pathfinderID] > 0)
        return found;
    if (startX == targetX && startY == targetY && pathLocation[pathfinderID] == 0)
        return nonexistent;


//3.Reset some variables that need to be cleared
    if ([onClosedList count] > 1000000) //reset whichList occasionally
    {
        for (int x = 0; x < mapWidth;x++) {
            for (int y = 0; y < mapHeight;y++)
                whichList[x][y] = 0;
        }
        [onClosedList removeAllObjects];
    }
    onClosedList = onClosedList+2; //changing the values of onOpenList and onClosed list is faster than redimming whichList() array
    onOpenList = onClosedList-1;
    pathLength [pathfinderID] = notStarted;//i.e, = 0
    pathLocation [pathfinderID] = notStarted;//i.e, = 0
    Gcost[startX][startY] = 0; //reset starting square's G value to 0

//4.Add the starting location to the open list of squares to be checked.
    numberOfOpenListItems = 1;
    openList[1] = 1;//assign it as the top (and currently only) item in the open list, which is maintained as a binary heap (explained below)
    openX[1] = startX ; openY[1] = startY;

//5.Do the following until a path is found or deemed nonexistent.
    do
    {

//6.If the open list is not empty, take the first cell off of the list.
//	This is the lowest F cost cell on the open list.
        if (numberOfOpenListItems != 0)
        {

//7. Pop the first item off the open list.
            parentXval = openX[openList[1]];
            parentYval = openY[openList[1]]; //record cell coordinates of the item

            NSNumber *onCloseListId = [NSNumber numberWithInt:onClosedList];
            whichList[parentXval][parentYval] = onCloseListId;//add the item to the closed list

//	Open List = Binary Heap: Delete this item from the open list, which
//  is maintained as a binary heap. For more information on binary heaps, see:
//	http://www.policyalmanac.org/games/binaryHeaps.htm
            numberOfOpenListItems = numberOfOpenListItems - 1;//reduce number of open list items by 1

//	Delete the top item in binary heap and reorder the heap, with the lowest F cost item rising to the top.
            openList[1] = openList[numberOfOpenListItems+1];//move the last item in the heap up to slot #1
            v = 1;

//	Repeat the following until the new item in slot #1 sinks to its proper spot in the heap.
            do
            {
                u = v;
                if (2*u+1 <= numberOfOpenListItems) //if both children exist
                {
                    //Check if the F cost of the parent is greater than each child.
                    //Select the lowest of the two children.
                    if (Fcost[openList[u]] >= Fcost[openList[2*u]])
                        v = 2*u;
                    if (Fcost[openList[v]] >= Fcost[openList[2*u+1]])
                        v = 2*u+1;
                }
                else
                {
                    if (2*u <= numberOfOpenListItems) //if only child #1 exists
                    {
                        //Check if the F cost of the parent is greater than child #1
                        if (Fcost[openList[u]] >= Fcost[openList[2*u]])
                            v = 2*u;
                    }
                }

                if (u != v) //if parent's F is > one of its children, swap them
                {
                    temp = openList[u];
                    openList[u] = openList[v];
                    openList[v] = temp;
                }
                else
                    break; //otherwise, exit loop

            }
            while (!KeyDown(27));//reorder the binary heap


//7.Check the adjacent squares. (Its "children" -- these path children
//	are similar, conceptually, to the binary heap children mentioned
//	above, but don't confuse them. They are different. Path children
//	are portrayed in Demo 1 with grey pointers pointing toward
//	their parents.) Add these adjacent child squares to the open list
//	for later consideration if appropriate (see various if statements
//	below).
            for (b = parentYval-1; b <= parentYval+1; b++){
                for (a = parentXval-1; a <= parentXval+1; a++){

//	If not off the map (do this first to avoid array out-of-bounds errors)
                    if (a != -1 && b != -1 && a != mapWidth && b != mapHeight){

//	If not already on the closed list (items on the closed list have
//	already been considered and can now be ignored).
                        if (whichList[a][b] != onClosedList) {

//	If not a wall/obstacle square.
                            if (walkability [a][b] != unwalkable) {

//	Don't cut across corners
                                corner = walkable;
                                if (a == parentXval-1)
                                {
                                    if (b == parentYval-1)
                                    {
                                        if (walkability[parentXval-1][parentYval] == unwalkable
                                                || walkability[parentXval][parentYval-1] == unwalkable) \
				corner = unwalkable;
                                    }
                                    else if (b == parentYval+1)
                                    {
                                        if (walkability[parentXval][parentYval+1] == unwalkable
                                                || walkability[parentXval-1][parentYval] == unwalkable)
                                            corner = unwalkable;
                                    }
                                }
                                else if (a == parentXval+1)
                                {
                                    if (b == parentYval-1)
                                    {
                                        if (walkability[parentXval][parentYval-1] == unwalkable
                                                || walkability[parentXval+1][parentYval] == unwalkable)
                                            corner = unwalkable;
                                    }
                                    else if (b == parentYval+1)
                                    {
                                        if (walkability[parentXval+1][parentYval] == unwalkable
                                                || walkability[parentXval][parentYval+1] == unwalkable)
                                            corner = unwalkable;
                                    }
                                }
                                if (corner == walkable) {

//	If not already on the open list, add it to the open list.
                                    if (whichList[a][b] != onOpenList)
                                    {

                                        //Create a new open list item in the binary heap.
                                        newOpenListItemID = newOpenListItemID + 1; //each new item has a unique ID #
                                        m = numberOfOpenListItems+1;
                                        openList[m] = newOpenListItemID;//place the new open list item (actually, its ID#) at the bottom of the heap
                                        openX[newOpenListItemID] = a;
                                        openY[newOpenListItemID] = b;//record the x and y coordinates of the new item

                                        //Figure out its G cost
                                        if (abs(a-parentXval) == 1 && abs(b-parentYval) == 1)
                                            addedGCost = 14;//cost of going to diagonal squares
                                        else
                                            addedGCost = 10;//cost of going to non-diagonal squares
                                        Gcost[a][b] = Gcost[parentXval][parentYval] + addedGCost;

                                        //Figure out its H and F costs and parent
                                        Hcost[openList[m]] = 10*(abs(a - targetX) + abs(b - targetY));
                                        Fcost[openList[m]] = Gcost[a][b] + Hcost[openList[m]];
                                        parentX[a][b] = parentXval ; parentY[a][b] = parentYval;

                                        //Move the new open list item to the proper place in the binary heap.
                                        //Starting at the bottom, successively compare to parent items,
                                        //swapping as needed until the item finds its place in the heap
                                        //or bubbles all the way to the top (if it has the lowest F cost).
                                        while (m != 1) //While item hasn't bubbled to the top (m=1)
                                        {
                                            //Check if child's F cost is < parent's F cost. If so, swap them.
                                            if (Fcost[openList[m]] <= Fcost[openList[m/2]])
                                            {
                                                temp = openList[m/2];
                                                openList[m/2] = openList[m];
                                                openList[m] = temp;
                                                m = m/2;
                                            }
                                            else
                                                break;
                                        }
                                        numberOfOpenListItems = numberOfOpenListItems+1;//add one to the number of items in the heap

                                        //Change whichList to show that the new item is on the open list.
                                        whichList[a][b] = onOpenList;
                                    }

//8.If adjacent cell is already on the open list, check to see if this
//	path to that cell from the starting location is a better one.
//	If so, change the parent of the cell and its G and F costs.
                                    else //If whichList(a,b) = onOpenList
                                    {

                                        //Figure out the G cost of this possible new path
                                        if (abs(a-parentXval) == 1 && abs(b-parentYval) == 1)
                                            addedGCost = 14;//cost of going to diagonal tiles
                                        else
                                            addedGCost = 10;//cost of going to non-diagonal tiles
                                        tempGcost = Gcost[parentXval][parentYval] + addedGCost;

                                        //If this path is shorter (G cost is lower) then change
                                        //the parent cell, G cost and F cost.
                                        if (tempGcost < Gcost[a][b]) //if G cost is less,
                                        {
                                            parentX[a][b] = parentXval; //change the square's parent
                                            parentY[a][b] = parentYval;
                                            Gcost[a][b] = tempGcost;//change the G cost

                                            //Because changing the G cost also changes the F cost, if
                                            //the item is on the open list we need to change the item's
                                            //recorded F cost and its position on the open list to make
                                            //sure that we maintain a properly ordered open list.
                                            for (int x = 1; x <= numberOfOpenListItems; x++) //look for the item in the heap
                                            {
                                                if (openX[openList[x]] == a && openY[openList[x]] == b) //item found
                                                {
                                                    Fcost[openList[x]] = Gcost[a][b] + Hcost[openList[x]];//change the F cost

                                                    //See if changing the F score bubbles the item up from it's current location in the heap
                                                    m = x;
                                                    while (m != 1) //While item hasn't bubbled to the top (m=1)
                                                    {
                                                        //Check if child is < parent. If so, swap them.
                                                        if (Fcost[openList[m]] < Fcost[openList[m/2]])
                                                        {
                                                            temp = openList[m/2];
                                                            openList[m/2] = openList[m];
                                                            openList[m] = temp;
                                                            m = m/2;
                                                        }
                                                        else
                                                            break;
                                                    }
                                                    break; //exit for x = loop
                                                } //If openX(openList(x)) = a
                                            } //For x = 1 To numberOfOpenListItems
                                        }//If tempGcost < Gcost(a,b)

                                    }//else If whichList(a,b) = onOpenList
                                }//If not cutting a corner
                            }//If not a wall/obstacle square.
                        }//If not already on the closed list
                    }//If not off the map
                }//for (a = parentXval-1; a <= parentXval+1; a++){
            }//for (b = parentYval-1; b <= parentYval+1; b++){

        }//if (numberOfOpenListItems != 0)

//9.If open list is empty then there is no path.
        else
        {
            path = nonexistent; break;
        }

        //If target is added to open list then path has been found.
        if (whichList[targetX][targetY] == onOpenList)
        {
            path = found; break;
        }

    }
    while (1);//Do until path is found or deemed nonexistent

//10.Save the path if it exists.
    if (path == found)
    {

//a.Working backwards from the target to the starting location by checking
//	each cell's parent, figure out the length of the path.
        pathX = targetX; pathY = targetY;
        do
        {
            //Look up the parent of the current cell.
            tempx = parentX[pathX][pathY];
            pathY = parentY[pathX][pathY];
            pathX = tempx;

            //Figure out the path length
            pathLength[pathfinderID] = pathLength[pathfinderID] + 1;
        }
        while (pathX != startX || pathY != startY);

//b.Resize the data bank to the right size in bytes
        pathBank[pathfinderID] = (int*) realloc (pathBank[pathfinderID],
                pathLength[pathfinderID]*8);

//c. Now copy the path information over to the databank. Since we are
//	working backwards from the target to the start location, we copy
//	the information to the data bank in reverse order. The result is
//	a properly ordered set of path data, from the first step to the
//	last.
        pathX = targetX ; pathY = targetY;
        cellPosition = pathLength[pathfinderID]*2;//start at the end
        do
        {
            cellPosition = cellPosition - 2;//work backwards 2 integers
            pathBank[pathfinderID] [cellPosition] = pathX;
            pathBank[pathfinderID] [cellPosition+1] = pathY;

//d.Look up the parent of the current cell.
            tempx = parentX[pathX][pathY];
            pathY = parentY[pathX][pathY];
            pathX = tempx;

//e.If we have reached the starting square, exit the loop.
        }
        while (pathX != startX || pathY != startY);

//11.Read the first path step into xPath/yPath arrays
        ReadPath(pathfinderID,startingX,startingY,1);

    }
    return path;


//13.If there is no path to the selected target, set the pathfinder's
//	xPath and yPath equal to its current location and return that the
//	path is nonexistent.
    noPath:
    xPath[pathfinderID] = startingX;
    yPath[pathfinderID] = startingY;
    return nonexistent;
}


@end