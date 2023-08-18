public class ScoreFile{
    int hiScore;
    public ScoreFile(){
        String[] words = loadStrings("scores.txt");
        if(words.length > 0){
            hiScore = Integer.parseInt(words[0]);
        }
    }

    public void saveScores(int score){
        if(score > hiScore)
            hiScore = score;
        updateFile();
    }

    public void updateFile(){
        String[] words = new String[1];
        words[0] = hiScore + "";
        saveStrings("scores.txt", words);

    }

    public int hiScore(){
        return hiScore;
    }
}