# make-table
Make command line style table

## easy to use

just put

```
"bar""foo"
"foo""bar"
```

and you will get

```
+---+---+
|bar|foo|
+---+---+
|foo|bar|
+---+---+
```

I called things like "foo" a **word**. Every thing a word will be neglect, which means you can easily put comma and space between word.Like this:

```
"bar", "foo"
"foo", "bar"
```

```
+---+---+
|bar|foo|
+---+---+
|foo|bar|
+---+---+
```

or something like this if you like:

```
"bar"1234567890"foo"
"foo"1234567890"bar"
```
The result is the same.

## interactive mode
use option -i to enter interactive mode.
