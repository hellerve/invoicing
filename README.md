# invoices

The code for an invoicing system built on LaTex, Pandoc, Mustache, and YAML.
It is very similar to the one I use—except that my offers and invoices are
usually in German and these are half-hearted translations. Don’t use the
text for anything real, I haven’t checked it. This is for educational
purposes only.

## Usage

You can generate offers and invoices with a Python script, using the following
command:

```
# this will generate offer 2020_0001
python publish.py offer 2020_0001

# this will generate invoice 2020_0001
python publish.py invoice 2020_0001
```

Examples for a rendered offer and invoice can be found [here](examples/).

<hr/>

Have fun!
