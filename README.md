# color_register
Interface study project.

This a Interface study project.

A project where you can insert a new, alter or delete by id or name and list (all) color.
After I learned about the pros in using interfaces in objectfied pascal languages I decided to practice with a fictious but functional project.

So I created a console application with Lazarus 1.4.4 and PostgresSQL 9.5.1.

Everything was made with interfaces and then naturally implemented in classes.

The current state of the project is: done, but can be continued.
It took: 2 weeks to finish it (current state).

The project is consisted of:
- A console view (a bunch of impletations of IView only with the Show procedure);
- Generic classes-methods to manipulate colors (alter, insert, list and delete, each method with a class);
- A connection with the PostgresSQL database through ZeosDB, by its interfaces (a nice side of zeos library);
- A color recipient (nothing more than a model-like class) and a color model (with its id).
- A class function New that is added at almost every class to return its interface with a instance of itself;

Interesting and useful stuff in this project:
- Uses the Zeos interfaces instead of its components. It is not a well known part of this library;
- Has interfaces and its class for every list of something (Integer, Color and Model, for example) needed in the project. Its a working example of a simple thing;
- Has a pure recipient and a model like recipient that contains the pure one;
- The class function New. An idea taken from the posts of the programmer Marcos Douglas, writer and owner of the blog Object Pascal Programming (http://objectpascalprogramming.com/);

Cons:
- Every class and interface was separated in a single file, so there is lots of *_class.pas and *_int.pas and one *_enum.pas files. A practice that I like to use since pascal has an interface and implemantation sections, each one separated;
- Since it uses interfaces, has practically a class for each interface, except for IView, that is implemented by view classes;
- Has more writed coding lines, since it doesn't uses components.
