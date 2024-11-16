public class Location implements Comparable{
  private int row,col;
  private float dist;
  
  /**COMPLETE THE COMPARE_TO 
  you may assume the other is a valid Location
  */
  public int compareTo(Object other){
    if (this.dist>((Location)other).dist){
      return 1;
    }
    else if (this.dist<((Location)other).dist){
      return -1;
    }
    else{
      return 0;
    }
     
  }
  
  
  /////////////DO NOT EDIT BELOW THIS LINE////////////////////
  
  /**Constructor of a location takes the distance to the ending location
  */
  public Location(int r, int c, float d){
   row =r;
   col =c;
   dist = d;
  }
  
  /**Do not use this version
  */
  public Location(int r, int c){
   row =r;
   col =c;
   dist = -1.0;
 }
}
