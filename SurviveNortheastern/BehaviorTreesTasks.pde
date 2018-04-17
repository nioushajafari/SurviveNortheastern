class ProfessorBehavior extends Task {
  Task behavior;
  
  ProfessorBehavior(int range, float hurtPower, float slowPower) {
    
    ArrayList<Task> seq = new ArrayList<Task>();
    seq.add(new ActTimerTick());
    seq.add(new RangeHurt(range, hurtPower));
    seq.add(new RangeSlow(range, slowPower));
    seq.add(new Condition(new InSight(), new MoveToPlayer(0), new RandomMove(0)));
    this.behavior = new Sequence(seq);
  }
  
  int execute(Level l, Enemy e) {
    return this.behavior.execute(l, e);
  }
}



class HuskyBehavior extends Task {
  int execute(Level l, Enemy e) {
    ArrayList<PVector> possibleMoves = l.tunnels.adjacentSpaces(new PVector(e.x, e.y));
    if (possibleMoves != null) {
      PVector selectedMove = possibleMoves.get((int) (Math.random() * possibleMoves.size()));
      e.x = (int)selectedMove.x;
      e.y = (int)selectedMove.y;
      return SUCCESS;
    } else {
      return FAIL;
    }
  }
}

class DragaounBehavior extends Task {
  int execute(Level l, Enemy e) {
    ArrayList<PVector> possibleMoves = l.tunnels.adjacentSpaces(new PVector(e.x, e.y));
    if (possibleMoves != null) {
      PVector selectedMove = possibleMoves.get((int) (Math.random() * possibleMoves.size()));
      e.x = (int)selectedMove.x;
      e.y = (int)selectedMove.y;
      return SUCCESS;
    } else {
      return FAIL;
    }
  }
}

class NUWaveBehavior extends Task {
  int execute(Level l, Enemy e) {
    ArrayList<PVector> possibleMoves = l.tunnels.adjacentSpaces(new PVector(e.x, e.y));
    if (possibleMoves != null) {
      PVector selectedMove = possibleMoves.get((int) (Math.random() * possibleMoves.size()));
      e.x = (int)selectedMove.x;
      e.y = (int)selectedMove.y;
      return SUCCESS;
    } else {
      return FAIL;
    }
  }
}

class RABehavior extends Task {
  int execute(Level l, Enemy e) {
    ArrayList<PVector> possibleMoves = l.tunnels.adjacentSpaces(new PVector(e.x, e.y));
    if (possibleMoves != null) {
      PVector selectedMove = possibleMoves.get((int) (Math.random() * possibleMoves.size()));
      e.x = (int)selectedMove.x;
      e.y = (int)selectedMove.y;
      return SUCCESS;
    } else {
      return FAIL;
    }
  }
}








class ActTimerTick extends Task {
  int execute(Level l, Enemy e) {
    if (e.actTimer >= e.actRate) {
      e.actTimer = 0;
    } else {
      e.actTimer += 1;
    }
    
    return SUCCESS;
  }
}

class RandomMove extends Task {
  int moveTick;
  
  RandomMove(int moveTick) {
    this.moveTick = moveTick;
  }
  
  int execute(Level l, Enemy e) {
    if (e.actTimer == this.moveTick) {
      ArrayList<PVector> possibleMoves = l.freeSpaces(l.tunnels.adjacentSpaces(new PVector(e.x, e.y)));
      if (possibleMoves != null) {
        PVector selectedMove = possibleMoves.get((int) (Math.random() * possibleMoves.size()));
        e.x = (int)selectedMove.x;
        e.y = (int)selectedMove.y;
        return SUCCESS;
      } else {
        return FAIL;
      }
    }
    return SUCCESS;
  }
}

class MoveToPlayer extends Task {
  int moveTick;
  
  MoveToPlayer(int moveTick) {
    this.moveTick = moveTick;
  }
  
  int execute(Level l, Enemy e) {
    if (e.actTimer == this.moveTick) {
      ArrayList<PVector> possibleMoves = l.freeSpaces(l.tunnels.adjacentSpaces(new PVector(e.x, e.y)));
      PVector selectedMove = new PVector(e.x, e.y);
      for (PVector m : possibleMoves) {
        if (manhattanDistance(l.playerLocation, m) < manhattanDistance(l.playerLocation, selectedMove)) {
          selectedMove = m;
        }
      }
      
      // Move Player to closest position
      e.x = (int)selectedMove.x;
      e.y = (int)selectedMove.y;
      return SUCCESS;
    }
    return SUCCESS;
  }
}

class RangeHurt extends Task {
  int range;
  float severity;
  
  RangeHurt(int range, float severity) {
    this.range = range;
    this.severity = severity;
  }
  
  int execute(Level l, Enemy e) {
    int distance = manhattanDistance(l.playerLocation, new PVector(e.x, e.y));
    if (distance <= this.range) {
      l.playerHealth -= this.severity * (this.range - distance);
    }
    
    return SUCCESS;
  }
}

class RangeSlow extends Task {
  int range;
  float slowFactor;
  
  RangeSlow(int range, float slowFactor) {
    this.range = range;
    this.slowFactor = slowFactor;
  }
  
  int execute(Level l, Enemy e) {
    
    int distance = manhattanDistance(l.playerLocation, new PVector(e.x, e.y));
    if (distance <= this.range) {
      l.playerMoveStall += slowFactor * (this.range - distance);
    }

    return SUCCESS;
  }
}