public class Grid{
    Block[][] grid;
    boolean canPlay;
    int scale;

    public Grid(int scale_){
        scale = scale_;
        grid = new Block[4][4];
        addRandomBlock();
        addRandomBlock();
    }

    public void addRandomBlock(){
        ArrayList<PVector> emptySpaces = getEmptySpaces();
        if(emptySpaces.size() <= 0){
            canPlay = false;
            return;
        }

        PVector newBlockLocation = emptySpaces.get((int)(Math.random() * emptySpaces.size()));
        int typeOfBlock = (int)(Math.random() * 4);
        Block newBlock = new Block();

        if(typeOfBlock == 0)
            newBlock = new Block((int)newBlockLocation.x, (int)newBlockLocation.y, scale, 4);
        else
            newBlock = new Block((int)newBlockLocation.x, (int)newBlockLocation.y, scale, 2);
        
        grid[newBlock.row()][newBlock.col()] = newBlock;
    }

    public void display(){
        updateBlocks();
        for(int r = 0; r < grid.length; r++){
            for(int c = 0; c < grid[r].length; c++){
                if(grid[r][c] != null){
                    grid[r][c].display();
                }
            }
        }
    }

    private void updateBlocks(){    
        for (int r = 0; r < grid.length; r++) {
            for (int c = 0; c < grid[r].length; c++) {
                if(grid[r][c] != null){
                    grid[r][c].setPos(r, c);
                    grid[r][c].setCanCombine(true);
                }
            }
        }
    }

    public String toString(){
        String output = "";
        for(int r = 0; r < grid.length; r++){
            for(int c = 0; c < grid[r].length; c++){
                if(grid[r][c] != null){
                    output += "[" + grid[r][c].value() + "]";
                } else 
                    output += "[ ]";
            }
            output += "\n";
        }
        return output;
    }

    public ArrayList<PVector> getEmptySpaces(){
        ArrayList<PVector> list = new ArrayList<PVector>();
        for(int r = 0; r < grid.length; r++){
            for(int c = 0; c < grid[r].length; c++){
                if(grid[r][c] == null)
                    list.add(new PVector(r, c));
            }
        }
        return list;
    }

    public void shift(String direction){
        System.out.println(toString() + "\n");
        
        if(direction.equals("up"))
            swapRows();
        if(direction.equals("right") || direction.equals("down"))
            swapCols();
        if(direction.equals("up") || direction.equals("down"))
            rotate();

        System.out.println(toString() + "\n");

        boolean hasChanged = false;

        for(int r = 0; r < grid.length; r++){
            for(int c = 0; c < grid[r].length - 1; c++){
                if(grid[r][c] == null && grid[r][c + 1] != null){
                    grid[r][c] = grid[r][c + 1];
                    grid[r][c + 1] = null;
                    grid[r][c].setPos(r, c);
                    c = -1;
                    hasChanged = true;
                }
                else if(grid[r][c] != null && grid[r][c + 1] != null && grid[r][c].value() == grid[r][c + 1].value() && grid[r][c].canCombine() && grid[r][c + 1].canCombine()){
                    combine(r, c, r, c + 1);
                    c = -1;
                    hasChanged = true;
                }
            }
        }

        System.out.println(toString() + "\n");

        if(direction.equals("up") || direction.equals("down")){
            rotate();
            rotate();
            rotate();
        }
        if(direction.equals("right") || direction.equals("down"))
            swapCols();
        
        if(direction.equals("up"))
            swapRows();
        
        if(hasChanged)
            addRandomBlock();

        System.out.println(toString() + "\n\n");
    }

    private void swapCols(){
        for(int r = 0; r < grid.length; r++){
            for(int c = 0; c < grid[r].length / 2; c++){
                Block b = grid[r][grid[r].length - c - 1];
                grid[r][grid[r].length - c - 1] = grid[r][c];
                grid[r][c] = b;
            }
        }
    }

    private void swapRows(){
        for(int c = 0; c < grid.length; c++){
            for(int r = 0; r < grid.length / 2; r++){
                Block b = grid[grid.length - r - 1][c];
                grid[grid.length - r - 1][c] = grid[r][c];
                grid[r][c] = b;
            }
        }
    }
    
    private void rotate(){
        Block[][] newGrid = new Block[grid.length][grid[0].length];
        for (int r = 0; r < grid.length; r++) {
            for (int c = 0; c < grid[r].length; c++) {
                newGrid[c][grid.length-1-r] = grid[r][c];
            }
        }
        grid = newGrid;
    }

    public void combine(int r1, int c1, int r2, int c2){
        if(grid[r1][c1] == null || grid[r2][c2] == null || grid[r1][c1].value() != grid[r2][c2].value())
            return;

        grid[r2][c2] = null;
        grid[r1][c1].increaseValue();
        grid[r1][c1].setCanCombine(false);
    }
}