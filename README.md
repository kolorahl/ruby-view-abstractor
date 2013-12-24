# rva

Ruby View Abstractor

## What is it?

If you have read [The Pragmatic Programmer][tppbook], you may recall that the
authors refer to many components of a system being "views" to your data,
a.k.a. models. The Ruby View Abstractor defines a DSL for Ruby data models and
their representation. The core concept is that the definition file(s) will be
run through the RVA processor along with particular views that you want to have
generate output.

What the heck does all that mean? Read on and I will tell you a story of a Rails
developer and the frustrations of even the simplest tasks, and how this approach
to development cut down on time, costs, and maintenance efforts. How fun!

## Standard Rails app, right?

So we have Jill. She's been hired to help in the development of a "standard"
Rails app. By standard we mean that the Rails app will interface with a database
(that's a fun phrase to say!), execute some business logic, and deliver web
pages to a user's browser. Bob, who has hired Jill, says he wants a simple news
system, almost like a blog, and he wants an interface for web app administrators
so they can post news to the site. Easy stuff.

## Good ol' model-view-controller

The model-view-controller (MVC) design pattern splits core code pieces by
responsibility. The _model_ code is everything related to database
interaction. The _view_ code is everything related to end-user display and
interaction. The _controller_ code deals with routing user requests to the
server, executing the appropriate business logic, and usually displaying a
view in response. Rails has _generators_ which automatically create boilerplate
code with some level of customization, and this helps reduce development time a
little. But only by a little.

## Task complete! Or is it?

Jill creates a _news post_ model and respective admin controller. She also
creates a few view templates for listing all news posts, creating new ones, and
editing existing ones. Let's say she did this early 2013 and used Twitter
Bootstrap 2 for the view stuff and `ActiveRecord` for the model
stuff. Also assume there are test cases, because Jill is an awesome developer
and would never forget her test cases - **ever**. Everything works as
expected. Yay! Task complete! Or is it...?

## Upgrade and core changes

Let's say Bob tells Jill he wants an update to Twitter Bootstrap 3 and that they
are possibly moving away from SQL databases, so they need to move off
`ActiveRecord` but keep core functionality as best they can, so they are moving
to `ActiveModel`. Jill could go into the few view and model files she created
and modify them, but what if further development was done before and after
completing the news posts task? What if there are over ten models and more than
twenty view files?

Maybe she could have created a base record class that all models inherit from,
but there are potential performance pitfalls with that approach. And for the
views, maybe she created a bunch of helpers to generate HTML fragments, which
does adhere to the [DRY][drywiki] principle but also comes with potential
performance pitfalls. But maybe Jill abstracted the conceptual data pieces and
generated performant models and views prior to deploying code.

And that's where `rva` comes into play. The Ruby view abstractor takes the
pragmatic approach to separating data at the conceptual level to data at the
implementation level, where everything is a "view". Models are a type of view,
web pages are a type of view, even documentation is considered a type of view!

## Jill uses rva to get things done

Let's assume there are already `rva` generators available for `ActiveModel` and
Twitter Bootstrap 3. In this case, all Jill does is grab those two generators,
pass them in to the `rva` builder using the existing data definitions, and she's
done. It's just that simple. The main driving force behind `rva` isn't its own
technology or execution, it's the standardization of data definitions and a
common interface to generating "views".

Once the data definitions are created, that's the only file(s) that should
require editing in the future. Everything else should be a matter of selecting
the correct view generators and passing in the appropriate options. And, of
course, you may always create your own generators or extend existing ones! It's
amazingly simple to do so. The hard part is in maintaining a proper data
definitions schema that a majority of developers can use as-is, so that a
generator will be able to be used verbatim by a large audience.

[tppbook]: http://www.amazon.com/gp/product/020161622X/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=020161622X&linkCode=as2&tag=kolorahl-20
[drywiki]: http://en.wikipedia.org/wiki/Don't_repeat_yourself
