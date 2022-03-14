# Sorting Random Integers

## Objectives
1. Using indirect addressing and/or base-indexed addressing
2. Passing parameters on the stack
3. Generating “random” numbers
4. Working with arrays

## Description
Write a MASM program to perform the tasks shown below. Be sure to test your program and ensure that it rejects incorrect input values.
1. Introduce the program.
2. Get a user request in the range [min = 15 .. max = 200].
3. Generate request random integers in the range [lo = 100 .. hi = 999], storing them in consecutive elements of an array.
4. Display the list of integers before sorting, 10 numbers per line.
5. Sort the list in descending order (i.e., largest first).
6. Calculate and display the median value, rounded to the nearest integer.
7. Display the sorted list, 10 numbers per line.

## Example Program Operation
```
Sorting Random Integers
Programmed by Author Name
This program generates random numbers in the range [100 .. 999],
displays the original list, sorts the list, and calculates the
median value. Finally, it displays the list sorted in descending order.
How many numbers should be generated? [15 .. 200]: 10
Invalid input
How many numbers should be generated? [15 .. 200]: 16
The unsorted random numbers:
680      329     279     846     123     101      427      913     255    736
431      545     984     391     626     803
The median is 488.
The sorted list:
984      913     846     803     736     680      626      545     431    427
391      329     279     255     123     101
Thanks for using my program!
```

## Requirements
1. The title, programmer's name, and brief instructions must be displayed on the screen.
2. The program must validate the user’s request.
3. The main procedure must consist (mostly) of procedure calls. It should be a readable “list” of what the program will do.
4. min, max, lo, and hi must be declared and used as global constants.
5. All procedure parameters must be passed on the system stack.
6. Each procedure will implement a section of the program logic, i.e., each procedure will specify how the logic of its section is implemented. The program must be modularized into at least the following procedures and sub-procedures:
    - main
    - introduction
    - get data {parameters: request (reference)}
    - fill array {parameters: request (value), array (reference)}
    - sort list {parameters: array (reference), request (value)}
      - exchange elements (for most sorting algorithms): {parameters: array[i] (reference), array[j] (reference), where i and j are the indices of elements to be exchanged}
    - display median {parameters: array (reference), request (value)}
    - display list {parameters: array (reference), request (value), title (reference)}
7. Parameters must be passed by value or by reference on the system stack as listed above.
8. There must be just one procedure to display the list. This procedure must be called twice: once to display the unsorted list, and once to display the sorted list.
9. Procedures (except main) should not reference .data segment variables by name. request, array, and titles for the sorted/unsorted lists should be declared in the .data segment, but procedures must use them as parameters. Procedures are allowed to use local variables when appropriate (section 8.2.9 in the textbook). Global constants are OK.
10. The program must use appropriate addressing modes for array elements.
11. The two lists must be identified when they are displayed (use the title parameter for the display procedure).
12. Each procedure must have a procedure header that follows the format discussed during lecture.
13. The code and the output must be well-formatted.
14. The usual requirements regarding documentation, readability, user-friendliness, etc., apply.

## Notes
1. **DO NOT** put this off - it is a much more time-intensive project than any of Programs #1 - #4.
2. The Irvine library provides procedures for generating random numbers. Call Randomize once at the beginning of the program (to set up so you don't get the same sequence every time), and call RandomRange to get a pseudo-random number. (See the documentation in Lecture slides.)
3. The Selection Sort is probably the easiest sorting algorithm to implement. Here is a version of the descending order algorithm, where request is the number of array elements being sorted, and exchange is the code to exchange two elements of an array:

```
for (k=0; k<request-1; k++) {
   i = k;
   for (j=k+1; j<request; j++) {
      if (array[j] > array[i])
         i = j;
   }
   exchange(array[k], array[i]);
}
```

4. The median is calculated after the array is sorted. It is the "middle" element of the sorted list. If the number of elements is even, the median is the average of the middle two elements (may be rounded).
5. If you choose to use the LOCAL directive while working on this program be sure to read section 8.2.9 in the Irvine textbook. LOCAL variables will affect the contents of the system stack!

## Extra Credit Options
- (0.5 pt) Add a greeting message that contains EXACTLY ONE TA name at the beginning of the program. If that TA happens to be your grader, then you get the points :)  
- (1 pt) Display the numbers ordered by column instead of by row.
- (3 pts) Implement the sorting functionality using a recursive Merge Sort algorithm. For a graphical explanation of the algorithm, I recommend this GeeksForGeeks article (Links to an external site.). You may add additional procedures to your program as needed. Remember that all parameters must be passed on the system stack.

In order to ensure you receive credit for any extra credit work, you must add one print statement to your program output PER EXTRA CREDIT which describes the extra credit you chose to work on. You will not receive extra credit points unless you do this. The statement must be formatted as follows...

```
--Program Intro--
**EC: DESCRIPTION
--Program prompts, etc--
```

Please refer back to the documentation for Program 1 to see a sample of the extra credit format.
