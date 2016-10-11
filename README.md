# UCI_LAB1X1_Prolog
Prolog Homework Assignment

1. Train Travel
  This knowledge base holds facts about towns it is possible to travel between by taking a non-stop train. We can travel further by `chaining together' non-stop train journeys. 
  Write a recursive predicate routeTrip/3 that tells us whether we can travel by train between two towns, and the route taken.
  Also, encode a relationship to express that travel can happen in both directions: A to B, and B to A.
2. Seating Chart
  As the host of a party, you are required to generate a seating chart for your guests. There will be 8-guests seated at a circular table.
  There are 4-male, 4-female guests and each guest has a unique set of hobbies. You decide that the following constraints must be met when seating guests:
    1) Adjacent seating partners must be of the opposite gender
    2) Adjacent seating partners must share at least one hobby
  You are to write the predicate, seatingChart(X), where X contains the names of the persons assigned to seats 1-8.
