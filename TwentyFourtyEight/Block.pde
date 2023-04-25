public class Block{
    private int row, col, scale;
    private int value;
    private color[] colors;
    private color clr;
    private boolean canCombine;

    public Block(int row_, int col_, int scale_, int value_){
        row = row_;
        col = col_;
        scale = scale_;
        value = value_;
        
        color[] colours = {#EFE5DB, #EFE2CF, #F5B37F, #F79A6C, #F67C5E, #F65E3C, #EED072, #EECC5F, #ECC84F, #EFCF6C, #EDCD5E, #3D3A33};
        colors = colours;
        updateColor();
    }

    public Block(){
        row = 0;
        col = 0;
        clr = color(255);
        scale = 0;
    }

    public int value(){
        return value;
    }

    public int row(){
        return row;
    }

    public int col(){
        return col;
    }

    public void increaseValue(){
        value *= 2;
        updateColor();
    }

    public void setValue(int newValue){
        value = newValue;
        updateColor();
    }

    public void updateColor(){
        if(value > 2048){
            clr = colors[11];
            return;
        }
        
        for(int i = 0; i < colors.length - 1; i++){
            if(Math.pow(2, i + 1) == value){
                clr = colors[i];
                break;
            }
        }
    }

    public boolean canCombine(){
        return canCombine;
    }

    public void setCanCombine(boolean newCanCombine){
        canCombine = newCanCombine;
    }

    public void display(){
        pushStyle();
        pushMatrix();
        
        int x = col * scale + scale / 2;
        int y = row * scale + scale / 2;

        rectMode(CENTER);
        fill(clr);
        rect(x, y, scale, scale);

        textAlign(CENTER);
        textSize(36);
        fill(0);
        text(value, x, y + 18);

        popMatrix();
        popStyle();
    }

    public void setPos(int newRow, int newCol){
        row = newRow;
        col = newCol;
    }
}