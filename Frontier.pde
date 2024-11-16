public class Frontier {
  private static final int STACK = 0;
  private static final int QUEUE = 1;
  private static final int HEAP = 2;
  private int MODE;
  private ArrayDeque<Location>deque;
  private PriorityQueue<Location>heap;

  /**Implement add for the other two modes.
  */
  public void add(Location place) {
    if (MODE == QUEUE) {
      deque.addLast(place);
    } 
    else if (MODE==STACK){
      deque.addLast(place);
    }
    else{
      heap.add(place);
    }
  }
  
  /**Implement remove for the other two modes.
  */
  public Location remove() {
    if (MODE == QUEUE) {
      return deque.removeFirst();
    }
    else if (MODE==STACK){
      return deque.removeLast();
    }
    else if (MODE==HEAP){
      return heap.remove();
    }
    else {
      return null;//This is for compilation purposes.
    }
  }
  
  
  /////////////DO NOT EDIT BELOW THIS LINE////////////////////
  

  public int size() {
    if (MODE == STACK || MODE == QUEUE) {
      return deque.size();
    } else {
      return heap.size();
    }
  }

  public void clear() {
    if (MODE == STACK || MODE == QUEUE) {
      deque.clear();
    } else {
      heap.clear();
    }
  }

  public Frontier(int mode) {
    MODE = mode;
    if (mode == STACK || mode == QUEUE) {
      deque = new ArrayDeque<Location>();
    } else if (mode == HEAP) {
      heap = new PriorityQueue<Location>();
    } else {
      throw new IllegalArgumentException("Please use Frontier.MODE, where MODE = HEAP/STACK/QUEUE");
    }
  }
}
