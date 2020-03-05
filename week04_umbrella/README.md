# Lesson 4 of IP Major (adding pages and working with ecto)

Before we start, you need to install a [MySQL local server](https://dev.mysql.com/downloads/file/?id=492814). 
Remember your MySQL password and username!

In `config/dev.exs` change the username and password tab to your MysQL username and password.

## Creating a new project

To reitarate creating a new project:

```bash
mix phx.new lesson04 --umbrella --database mysql
```

Commit to a Github repository if you want to.

## A new route

We'll mainly be busy in the `apps/lesson04_web/lib/lesson04_web/` folder. 

Phoenix generates a `apps/lesson04_web/lib/lesson04_web/router.ex` file. This file is the main file which routes us to controllers to get to the right views. 

If you run your application with

```bash
mix phx.server
```

and go to [localhost:4000](http://localhost:4000) you can see a Phoenix welcome page.

To test pages out, we'll be adding a simple 'Hello World' at [http://localhost:4000/hello](http://localhost:4000/hello).

To do this we add 
```elixir
get "/hello", Lesson04Controller, :index
```
to the "/" scope in `apps/lesson04_web/lib/lesson04_web/router.ex`. 

The `:index` means that it will execute `index` method in `Lesson04Controller`.

### Tip for Windows Users

When running the `mix phx.server` command, it is best to run it in cmd because you can't CTRL^C to stop the process in Git Bash. In order to not `cd ..` everytime, you can just open your root folder and type `cmd` in the address bar. This will open up a cmd with your work location set to your root folder.

## A new controller

We create a new `lesson04_controller.ex` in `apps/lesson04_web/lib/lesson04_web/controllers/`.

We add this to it:
```elixir
defmodule Lesson04Web.Lesson04Controller do
    use Lesson04Web, :controller
  
    def index(conn, _params) do
      render(conn, "index.html")
    end
  end   
```

We see the `index` method needs 2 arguments. The `conn` argument is quite logical, this is basically the request argument if compared to Java Servlets. The `_params` parameter is for parameters (like `request.addParameter(...)`). The only difference is that the `_` means the `index` can also be executed with only one argument to avoid compiler warnings.

The core of this action is `render(conn, "index.html")`. This tells Phoenix to find a template called index.html.eex and render it. Phoenix will look for the template in a directory named after our controller, so `apps/lesson04_web/lib/lesson04_web/templates/lesson04`.

## A new view 

Phoenix views are important. They basically render the templates. ***They act as a presentation layer for raw data from the controller*** preparing it for use in a template.

In order to render our templates (later) for our `Lesson04Controller` we need a `Lesson04View`. ***These names before Controller and View must*** match in order to find 'eachother'.

Make `Lesson04View.ex` in `apps/lesson04_web/lib/lesson04_web/views/` and make it look like this:

```elixir
defmodule Lesson04Web.Lesson04View do
  use Lesson04Web, :view
end
```

## A new template 

Now we just need our webpage. In elixir, these are called templates and end in `EEx` (or `eex`). This stands for `Embedded Elixir` This means it enables automatic escaping of values and protects you from XSS scripting (trauma's from projectweeks).
This does means that, for example, an `index.html` becomes `index.html.eex`. Yes, with 'two' extensions.

Templates are scoped to a view, which are scoped to a controller. For the sake of organization, we'll namespace the templates. 
We create a `lesson04` folder in `apps/lesson04_web/lib/lesson04_web/templates/`.

In this newly created folder, create a `index.html.eex` file and put this in:

```html
<div class="phx-hero">
  <h2>Hello World, from Phoenix!</h2>
</div>
```

## Testing the server

Now that all this is done, when you run `mix phx.server` and go to [http://localhost:4000/hello](http://localhost:4000/hello)
you should be able to see your new file.

If you kept your server running and just went straight to `/hello` you'll see that it directly works and didn't need a server restart. This is because Phoenix has hot code reloading. You've probably noticed that despite only having a <div> tag, there's more than that on the page. This is because the index template is rendered through the application layout (located at `apps/lesson04/lib/lesson04_web/templates/layout/app.html.eex`). The line of code that makes this possible in this file is 
```html
<%= render @view_module, @view_template, assigns %>
```
It renders the template into the template before the HTML is sent off to the server.

### The complete project until now can be found on the master branch of this repository.

## Little Excercise (might need to have made your Elixir excercises) //TD: Needs to be checked

Add a new page so that `http://localhost:4000/hello/:messenger` outputs `Hello World, from :messenger!` where `:messenger` is whatever you typed in. (you can use the same html as the `index.html.eex` we used before.). Create a new `show/2` method for this in the same Controller for `Lesson04Controller`.

<details>
<summary>Hints</summary>
1 You need to add a new get `router.ex`

2 You need to add a new action in the `Lesson04Controller` for `show`. Inside `show/2`, you need `render/3`.

3 You need to make a new template with similar output to JSTL from Java Servlet. 

4 You can use @ inside Elixir Expressions to call the parameter.

</details>

The solution can be found in the dev branch.


All information is gathered from [Hexdocs](https://hexdocs.pm/phoenix/adding_pages.html#a-new-view).
