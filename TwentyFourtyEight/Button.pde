public class Button{
    color textColor, buttonColor;
    int x, y, w, h;
    boolean clicked, released;
    String text;

    public Button(String text_, color textColor_, int x_, int y_, int w_, int h_, color buttonColor_){
        text = text_;
        textColor = textColor_;
        buttonColor = buttonColor_;
        x = x_;
        y = y_;
        w = w_;
        h = h_;
    }

    public void display(){
        pushStyle();
        pushMatrix();
        
        rectMode(CENTER);
        fill(buttonColor);
        rect(x, y, w, h);

        fill(textColor);
        textAlign(CENTER);
        int textSize = (int)(w / text.length() * 1.5);
        textSize(textSize);
        text(text, x, y + textSize / 3);

        popMatrix();
        popStyle();
    }

    public void mousePressed(){
        if(!mouseIsOnButton())
            return;
        clicked = true;
        buttonColor = color((int)(red(buttonColor) * 0.8), (int)(green(buttonColor) * 0.8), (int)(blue(buttonColor) * 0.8));
    }

    public void mouseReleased() {
        if(clicked){
            buttonColor = color((int)(red(buttonColor) * 1.25), (int)(green(buttonColor) * 1.25), (int)(blue(buttonColor) * 1.25));
            clicked = false;
            released = true;
        }
    }

    private boolean mouseIsOnButton(){
        if(mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2)
            return true;
        return false;
    }

    public boolean hasBeenPressed(){
        if(released){
            released = false;
            return true;
        }
        return false;
    }
}