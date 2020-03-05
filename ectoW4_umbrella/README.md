# Ecto in Phoenix

Ecto is basically a layer between your back-end and your database to validate user input. 

It works with PostGreSQL and MySQL, we'll be using MySQL.

## Setting up your MySQL Environment

If you didn't install MySQL before, go do it [here](https://dev.mysql.com/downloads/file/?id=492814).

If you've correctly set it up, you should be able to go into cmd and start a MySQL console with 
```bash
mysql -u root -p
```
You might need to replace `root` with your own username you put in the MySQL installation.

If this doesn't work, you might have to add the System Variable.

<details>
<summary>Adding the system variable</summary>
1 Open up configuration panel

2 Go to Systems and security >> System >> Advanced System Settings (left of the screen)

3 Go to Environment Variables

4 On the System Variables tab, search for the 'PATH' (or 'path') variable. Click edit

5 Click on new and add your lib folder of MySQL. (it should look something like this: `C:\Program Files\MySQL\MySQL Server 8.0\bin`).

6 Try to launch MySQL up with cmd again.

</details>

Note: MySQL in cmd won't work without a `;`, unlike PostGreSQL.

## ecto.create

You can continue using your project of lesson04 without ecto, but for the sake of simplicity we'll create a new project with umbrella and a MySQL database. 
You should now the drill by now.

After creating your project, go to `\config\dev.exs` and edit the database variables to your database.

After this, execute these commands:
```bash
$ mix ecto.create
```

This basically creates your database. 

After this we will create a dummy schema in your Ecto database. This can be done with `mix phx.gen.schema`. To make it easier for you, here is a dummy schema to create: 

```bash
$ mix phx.gen.schema User users name:string email:string \ bio:string number_of_pets:integer
```

For some reason unknown to me (and a non-issue to the internet) the command above needs to be executed in your `apps/{project_name}` (so NOT your `_web` one!) folder.

To migrate your changes, put in following command
```bash
$ mix ecto.migrate
```
This can be seen in MySQL with this command.

```mysql
show databases;
```

You should be able to see your database (as you named it in `dev.exs`) in the output (possibly other databases too, but these are completely unrelated).

## ecto.migrate

What ecto.migrate really do is create the specified columns in `apps\ectoW4\priv\repo\migrations\`.

We can also look more detailled at the database in MySQL with `describe {name}.Users`.
You can see it automatically added an `id` as primary key, as well as an `inserted_at` and `updated_at`. These speak for themselves.

## Back to ecto.create!

`ecto.create` also made the main repository at `lib/{project_name}/repo.ex`.
It also adds the adapter for our used database, which we'll come back to later.

Our schema also made the `user.ex` file in `/lib/{project_name}/`.

# Changesets

And now, the biggest part of this guide. We're not at `CRUD` yet, but we're getting there. Before we start with `CRUD` we'll look at validation first.

Changesets define a pipeline of transformations our data needs to undergo before it will be ready for our application to use. These transformations include type-casting, user input validation, and filtering out any extraenous parameters. We'll validate user input before sending it to the database. Ecto Repos are aware of changesets which allows them to not only refuse invalid data, but also perform minimal database updates by inspecting the changeset and which fields have changed. 

In our `user.ex`, we see a default `changeset` function. There are two functions. `cast/3` and `validate_required/3`.
First argument present takes a struct, then the parameters and a list of columns to be updated (We're not updating our columns yet, that's why we leave it empty).
`validate_required` is pretty straightforward. It checks if all the parameters returned by cast are present.

Our whole `changeset` function can be tested with
```bash
$ iex -S mix
```
Like for `mix phx.server`, this can't be stopped in Git Bash. I recommend to launch this with cmd or you'll have to close the `erl` process everytime with Task Manager.

First, we'll alias our User struct and our {project_name} in this guide. I will use `Hello` but you have to change it with whatever your project name is. (Do not forget capital letters!)

```bash
iex> alias Hello.User
## Which should result in
Hello.User
```

Next, we'll build a changeset with an empty User struct and empty parameters.

```bash
iex> changeset = User.changeset(%User{}, %{})

## Output will be:

#Ecto.Changeset<action: nil, changes: %{},
 errors: [name: {"can't be blank", [validation: :required]},
  email: {"can't be blank", [validation: :required]},
  bio: {"can't be blank", [validation: :required]},
  number_of_pets: {"can't be blank", [validation: :required]}],
 data: #Hello.User<>, valid?: false>
 ```

With this changeset we can run a first test with

```bash
iex> changeset.valid?
## Which should result
false
```

Hmm, it's not valid. Let's see those errors:

```bash
iex> changeset.errors
## Which should result
[name: {"can't be blank", [validation: :required]},
 email: {"can't be blank", [validation: :required]},
 bio: {"can't be blank", [validation: :required]},
 number_of_pets: {"can't be blank", [validation: :required]}]
 ```

That makes sense, we didn't put in any parameters! But hey, not everyone has pets. Let's remove that validation requirement in `user.ex`. Make sure to also remove the comma.

We can re-run our program without restarting it with `recompile()`.
After recompiling, you need to re-set your alias. 

Lets put in our changeset in again:

```bash
iex> changeset = User.changeset(%User{}, %{})
```

When testing with `changeset.errors` we can see that `number_of_pets` doesn't return an error anymore.

Now let's create a `params` map with valid values and a random value.

```bash
iex> params = %{name: "Joe Example", email: "joe@example.com", bio: "An example to all", number_of_pets: 5, random_key: "random value"}
```

Now lets execute changeset with `params` as second parameter.

```bash
iex> changeset = User.changeset(%User{}, params)
## Which should result in
#Ecto.Changeset<action: nil,
 changes: %{bio: "An example to all", email: "joe@example.com",
   name: "Joe Example", number_of_pets: 5}, errors: [],
 data: #Hello.User<>, valid?: true>
 ```

When running `changeset.valid?` we can see the tests pass. (If you have any errors with this, try `changeset.errors` to see errors and try to fix them on your own.)

We can also see the `changeset`'s changes with
```bash
iex> changeset.changes
## Output should be (something like)
%{bio: "An example to all", email: "joe@example.com", name: "Joe Example",
  number_of_pets: 5}
```

Remember our random value? I don't either, because they've been removed from our final changeset. Changesets allow us to cast external data like user input or data from a CSV file but invalid parameters will always be striped as well as bad data will, thanks to our schema. 

# Validation
Now that we've seen changesets and requirements, it's time for validation since there is more than `NOT_NULL` to user input.
For example, in `user.ex`, let's add a minimum length for `:bio`.
```elixir
def changeset(%User{} = user, attrs) do
  user
  |> cast(attrs, [:name, :email, :bio, :number_of_pets])
  |> validate_required([:name, :email, :bio, :number_of_pets])
  |> validate_length(:bio, min: 2)
end
```

Now, `recompile()` again and execute these commands. The changeset will only cast data containt "A" for the user's bio. The second command will look for errors for the `:bio` parameter.

```bash
iex> changeset = User.changeset(%User{}, %{bio: "A"})
iex> changeset.errors[:bio]
## Output should be
{"should be at least %{count} character(s)",
 [count: 2, validation: :length, min: 2]}
 ```

Now, as an exercise, add a validation that `:bio` can be a maximum of 140 characters.

<details>
<summary>Solution</summary>
1 '|> validate_length(:bio, max: 140)' in your `user.` ex file.
</details>

But it does't stop here. Say, we want to check if an email is correctly put in. We can add `|> validate_format(:email, ~r/@/)` to our `user.ex` file and test it out with a changeset:

```bash
iex> changeset = User.changeset(%User{}, %{email: "example.com"})
iex> changeset.errors[:email]
## Output should be
{"has invalid format", [validation: :format]}
```

# Data persistence

Incoming!

