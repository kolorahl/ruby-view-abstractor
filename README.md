# rva

Ruby View Abstractor

## What is it?

If you have read [The Pragmatic Programmer][tppbook], you may recall that the
authors refer to many components of a system being "views" to your data,
a.k.a. models. The Ruby View Abstractor defines a DSL for Ruby data models and
their representation. The core concept is that the definition file(s) will be
run through the RVA processor along with particular views that you want to have
generate output.

For example, you could use RVA to create `ActiveModel` classes, admin `ERB`
views, and HTML documentation. Or perhaps you want to generate LaTeX
documentation and use some custom `ActiveModel` derivative for your model
classes.

## How does it work?

Quite simple. RVA processes the one or more definition files, turns it into a
standardized Ruby `Hash` of information, and then calls all the necessary view
"generators", passing it the definition data. All generators should have a
single entry point method conforming to a particular set of inputs and
outputs. Assuming the generator has followed the contract stated by the RVA
calling component, everything should generate without flaw.

## I want to generate (insert anything here), help!

If you would like, you could contribute by creating your own generator to do
exactly what you want, as long as you conform to the contract specified by
RVA. Then you could hand it out to others in the community, host it somewhere
public for peer review and editing, or create a gem out of it to share with
others in a more easily consumed form.

## Is it any good?

Yes. Why, you ask? Because RVA turns up the model-view portion of
model-view-controller to [eleven][onelouder].

[tppbook]: http://www.amazon.com/gp/product/020161622X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=020161622X&linkCode=as2&tag=kolorahl-20
[onelouder]: http://www.youtube.com/watch?v=_sRhuh8Aphc
