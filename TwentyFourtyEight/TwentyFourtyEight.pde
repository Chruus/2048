void setup(){
    size(500, 500);
    grid = new Grid(100);
}
Grid grid;

void draw(){
    background(40);
    grid.display();
}

void keyReleased(){
    if(key == 'w')
        grid.shift("up");
    if(key == 's')
        grid.shift("down");
    if(key == 'a')
        grid.shift("left");
    if(key == 'd')
        grid.shift("right");
    
    if(key == CODED){
        if(keyCode == UP)
            grid.shift("up");
        if(keyCode == DOWN){
            grid.shift("down");
        if(keyCode == LEFT)
            grid.shift("left");
        if(keyCode == RIGHT)
            grid.shift("right");
        }
    }
}