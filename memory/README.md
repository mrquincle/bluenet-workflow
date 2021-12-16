# How to use

```
cd ..
export TARGET=default
./documentation.sh $TARGET memory_map
```

Now open the browser in this directory:

```
xdg-open index.html
```

It might be that you'll need some options like `--new-window --allow-file-access-from-files` for your particular browser (say Chrome).

Then search for the `bluenet/build/$TARGET/crownstone.map` file and open it to browse its contents.

# Upstream

The html file comes from https://github.com/eliotstock/memory.
