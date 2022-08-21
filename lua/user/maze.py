'''-----------------------------------------------------------------------------
Dylan Fender
ID # 3100128
CMPT-200-X04L(1)
================================================================================
                     ███╗   ███╗ █████╗ ███████╗███████╗
                     ████╗ ████║██╔══██╗╚══███╔╝██╔════╝
                     ██╔████╔██║███████║  ███╔╝ █████╗  
                     ██║╚██╔╝██║██╔══██║ ███╔╝  ██╔══╝  
                     ██║ ╚═╝ ██║██║  ██║███████╗███████╗
                     ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝
================================================================================

maze.py is a practice program for backtracking recursive exploration. 
It is paired with a number of text-based maze files, passed into a Maze class
that will solve them recursively. 

-----------------------------------------------------------------------------'''

# For VSCode ---Establishes parent folder for workspace.(so file import works)
import os
import sys

class Maze:
    def __init__(self, maze_txt, seq):
        '''
        Purpose:    
                    Takes in list of lines from maze text files, solves them
                    recursively, and marks them as solvable or not. 
        Parameters:
                    maze_txt     - Maze text file. Used to 
                                   extract coordinates, and the maze characters
                                   are converted to a maze list of lists, 
                                   used as a 2d grid.
                    
                    seq           - direction order for the solving algorithm, 
                                   represented by a 4 letter string, e.g. "NSWE"
        Returns:
                    None
        '''
        self.solvable = False # Default value until solved
        self._txt_lines = self._txt_to_lines(maze_txt) # txt file conv to list
        self._maze = self._lines_to_lists(self._txt_lines)[3:]# Maze Grid
        self.seq = self._seq_config(seq) # convert string 
        self._set_internal_coords()    # translates coords to internal structure 
        self._mark_start(self._strt_r,self._strt_c) # Mark starting pos.
        if self.solve(self._strt_r, self._strt_c):  # Start solving
            self.solvable = True                    # If solved, mark solvable
    
    
    def __str__(self):
        '''
        Purpose:    
                    __str__ overload for printing of the Maze object.
        Parameters:
                    None 
        Returns:
                    maze_str - str representation of the maze if solved.
                            - "Maze has no solution" if maze unsolvable. 
        '''
        maze_str = ''
        if self.solvable:
            for line in self._maze:
                for char in line:
                    if char == '#':
                       maze_str += ' '
                    else:
                        maze_str += char
                maze_str += '\n'
        else: maze_str = 'Maze has no solution'
        return maze_str


    def solve(self, r, c):
        '''
        Purpose:    
                    Recursive algorithm for navigating through a maze til
                    completion or failure in the case of an unsolvable maze.

                    Pseudocode:
                        Base Case = End Reached
                        
                        For directions in search order:
                            if move available
                                move to new space
                                fill new space
                                call solve (return True if Solve returns True)
                                fill new space with "travelled" char e.g. '#'
                        Return False if no moves avail in any direction
                                
        Parameters:
                    r - current row
                    c - current column
        Returns:
                    True  - if solved/end reached
                    False - if unsolvable/break condition reached
        '''
        # BASE CASE:
        if self._end_reached(r, c): 
            return True
        
        for direction in self.seq:
            if self._can_move(r, c, direction):
                nr, nc = self._move(r, c, direction) #new row, new col= new pos
                self._fill_square(nr, nc, '*')
                if self.solve(nr, nc):
                    return True
                self._clear_pos(nr, nc) 
        return False    


#=============================HELPER FUNCTIONS==================================

#------------------------------SETUP-HELPERS------------------------------------


    def _digit_formatter(self, coords):
        '''
        Purpose:    
                    Used in _set_internal_coords().
                    Code ripped from input_digit_scan() from lab 4. 
                    Processes a list of characters, formatting numbers
                    to proper state, e.g. ['1', ' ', '1', '0'] - > [1, 10]
        Parameters:
                    coords - a list of nums in string format, with spaces
                             between them.
        Returns:
                    Returns the coordinates with formatted digits, in list form 
        '''
        coord_lists = []
        for line in coords:  # First 3 rows with coords
            num_list = []
            i_count = 0   # iteration count, used for checking if end of str
            n = ''
            for num in line:
                i_count += 1
                if num.isdigit(): # Add each digit that belongs together to
                    n += num      # the digit string
                    if i_count == len(line): # End of line reached
                        num_list.append(int(n)) # Append number
                        coord_lists.append(num_list) # Append num list to coords
                elif num == ' ' and n != '': 
                    num_list.append(int(n))
                    n = ''
        return coord_lists


    def _lines_to_lists(self, lines):
        '''
        Purpose:    
                    Used in __init__ and _set_internal_coords()
                    Converts lists of line strings from a text document into
                    a list of lists
                    
        Parameters:
                    lines    - list of text lines from the .txt file.
        Returns:
                    txt_grid -  list of lines extracted from lines given.
                                Lines here are lists of characters contained in 
                                each line. 
        '''
        txt_grid = []
        for line in lines:
            line_list = []
            for char in line:
                line_list.append(char)
            txt_grid.append(line_list)
        return txt_grid


    def _mark_start(self, r, c):
        '''
        Purpose:    
                    Used in __init__
                    Helper function to mark the starting position. Can be used
                    to mark the starting position with a custom character.
        Parameters:
                    r - current row
                    c - current column
        Returns:
                    None
        '''
        if (r, c) == self._i_start:
            self._fill_square(r, c, '*')


    def _seq_config(self, search_order):
        '''
        Purpose:    
                    Used in __init__
                    Creates a list to hold tuples that represent directions.
                    Sets the tuple based on the search_order given.
        Parameters:
                    search_order - a string of four characters, representing 
                    the order of directions to take. 
                    e.g. "NSEW" -> North, South, East, then West.
        Returns:
                    directions - a list of tuples, representing directions to
                    go, in the correct order given.
        '''
        directions = []
        
        for char in search_order:
            if   char == 'N': directions.append((-1,  0))
            elif char == 'S': directions.append(( 1,  0))
            elif char == 'W': directions.append(( 0, -1))
            elif char == 'E': directions.append(( 0,  1))
        return directions 


    def _set_internal_coords(self):
        '''
        Purpose:    
                    Used in __init__
                    Extracts the size, start, and end coordinates given by the
                    text file, then converts them to an internal size structure.
                    
        Parameters:
                    None Given.
                    _i_size   - internal size coordinates, double raw size
                    _i_start  - internal start coordinates, adjusted for python
                    _i_dest   - internal destination coordinate, adjusted.
                    _i_strt_r - internal starting row, used for marking start
                    _i_strt_c - internal starting col, used for marking start 
                    ROWS      - Row constant, from internal size. Used for iter.
                    COLS      - Col constant, from internal size. Used for iter.
        Returns:
                    None 
        '''
        # Grab coords from the list of lines from the text file.
        _raw_coords = self._lines_to_lists(self._txt_lines)[:3] #Coords from file
        # Format coordinates, merge digits that are in same num, '2', '0' -> 20
        self._coords = self._digit_formatter(_raw_coords)

        size         = (self._coords[0][0], self._coords[0][1]) # Size  provided
        start        = (self._coords[1][0], self._coords[1][1]) # Start provided
        end          = (self._coords[2][0], self._coords[2][1]) # End   provided
        self._i_size  = ((size[0]*2), (size[1]*2))
        self._i_start = ((self._i_size[0] - (start[0]*2-1)), (start[1]*2-1))
        self._i_dest  = (self._i_size[0] - (end[0]*2 -1), (end[1]*2-1))
        self._strt_r, self._strt_c = self._i_start[0], self._i_start[1] 
        self.ROWS, self.COLS = self._i_size       # Used for iterations
       #------------------------DEV-HELPER--------------------------------------
        #print(f"Size:            {size}")
        #print(f"Start:           {start}")
        #print(f"End:             {end}")
        #print(f"Internal Size:   {self._i_size}")
        #print(f"Internal Start:  {self._i_start}")
        #print(f"Internal End:    {self._i_dest}")
 

    def _txt_to_lines(self, maze_txt):
        '''
        Purpose:    
                    Used in __init__
                    Takes in a text file, parses each line, adding the line to 
                    a list that it then returns.
        Parameters:
                    maze_txt - a text file with 3 lines of coordinates, then
                               any number of lines that represent a maze.
        Returns:
                    maze_list - a list of lines from the maze_txt file.
        '''
        maze_list = []
        for line in maze_txt:
            line = line.strip('\n')
            maze_list.append(line)
        maze_txt.close()
        return maze_list
#-------------------------------SOLVE()-HELPERS---------------------------------


    def _can_move(self, r, c, direction):
        '''
        Purpose:    
                    Checks the maze for available position in direction given.  
                    
        Parameters:
                    r         - current row 
                    c         - current column
                    direction - direction to move to, represented by a tuple,
                                e.g. (0, -1) -> one column to the left 
        Returns:
                    True  if new position is open.
                    False if new position is not open e.g. blocked by wall char.
        '''
        if r < self.ROWS and c < self.COLS:
            nr, nc = self._move(r, c, direction)
            if self._maze[nr][nc] == ' ':
                return True
            else: 
                return False
            
            
    def _clear_pos(self, r, c):
        '''
        Purpose:    
                    Marks a visited position with a '#', helps the solve algo
                    know when a position has been visited. It's one line, but
                    helps for readability in the solve function.
        Parameters:
                    r    - current row 
                    c    - current column
        Returns:
                    None
        '''
        self._maze[r][c] = '#'


    def _end_reached(self, r, c):
        '''
        Purpose:    
                    Checks if end has been reached.
                    Marks the final spot if end. 

        Parameters: 
                    r - current row
                    c - current column
        Returns:
                    True if coords match the destination coordinates 
                         (end reached)
        '''
        if (r, c) == self._i_dest:
            self._fill_square(r, c, '*')
            return True
    
    
    def _move(self, r, c, direction):
        '''
        Purpose:    
                    Applies operations to row and column based on direction
                    tuple given. e.g. if (0, 1) was given, row will stay 
                    the same, and col will be increased by 1.
        Parameters:
                    r         - row
                    c         - col
                    direction - tuple of two digits, representing a direction
                                to move to
        Returns:
                    r         - updated row 
                    c         - updated col
        '''
        r += direction[0]
        c += direction[1]
        return r, c


    def _fill_square(self, r, c, sign):
        '''
        Purpose:    
                    Fills current position in maze with the sign given.
        Parameters:
                    r    - current row
                    c    - current col
                    sign - sign to change the current space into
        Returns:
                    None.
        '''
        # Set a specific row/col as asterisk if potential path
        self._maze[r][c] = sign



#===========================TOP LEVEL FUNCTIONS================================

def main():
    '''
    Purpose:    
                Prompts user for search order, then prompts for maze filename.
                Opens file from filename, then creates a Maze object, passing
                the file and the search order, then prints the maze object.
                The print statement will either be a completed maze, or a 
                message reporting that the maze is unsolvable.
    Parameters:
                None
    Returns:
                None 
    '''
    # prompt the user for a search order : eg. NWES

    seq = input("Please enter the search order: ")
    filename = input("Please enter the name of the maze file: ")
    maze_list = file_opener(filename)
    maze = Maze(maze_list, seq)
    print(maze) 

    
def test(seq):
    '''
    Purpose:    
                Using the list of filenames, opens each file and processes it
                and the search order into a maze_obj, then reports
                if solvable or not.
    Parameters:
                search_order - directional order for maze solving navigation.
    Returns:
                None
    '''
    mazes = ['maze.txt', 'maze510.txt', 'maze510cycles.txt', 
             'maze510island.txt', 'maze510islandnosoln.txt',
             'maze510nosoln.txt', 'maze1020.txt', 'maze3040.txt',
             'maze3050.txt']
    # Run it through all test mazes provided
    for maze in mazes:
        print("\n")
        maze_txt = file_opener(maze)
        print(f"Testing  {maze}")
        maze_obj = Maze(maze_txt, seq)
        report_solvable(maze_obj) # report msg if (not)solvable


#----------------------------Top Level Helpers---------------------------------

def file_opener(filename): 
    '''
    Purpose:    
                Attempts to open file from filename given. If that is not found
                in root dir, it will attempt to open the default maze.txt.
                If that is not available, it will print "File Not Found"
    Parameters:
                filename - name of file to open
    Returns:
                maze_txt - an opened maze txt file
    '''
    try:
        maze_txt = open(filename, 'r')
        return maze_txt
    except:
        try:
            maze_txt = open('maze.txt', 'r')
            return maze_txt
        except:
            print("File Not Found")
    
def report_solvable(maze_obj):
    '''
    Purpose:    
                Used in test()
                Helper function for test(), reports if maze is solvable or not.
    Parameters:
                maze_obj - a Maze object 
    Returns:
                None
    '''
    if maze_obj.solvable:
        print(maze_obj)
        print("Maze has a solution")
    else: print("Maze has no solution")

#==============================================================================


if __name__ == '__main__':
    if sys.argv:
        filepath = sys.argv[0]
        folder, filename = os.path.split(filepath)
        os.chdir(folder)
    test('SENW')
