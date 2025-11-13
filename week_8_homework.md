# Week 8 homework

In week 9, we will be using git, conda and snakemake on BluePebble. Using git and conda on BluePebble requires some setup that needs to be done before the week 9 teaching. If you have any problems with the setup, please ask questions through Blackboard or come to the drop-in session at 9:30 on Thursday 21st November (immediately before the week 9 lecture, which will start at 10am).

## 1. Create an SSH key 

Open a new Linux terminal and run:

``` 
ssh-keygen -t ed25519 -C <your email address>
```

When you are asked where to save the key, press enter to use the default location.

You will then be asked for a passphrase. If you choose to use a passphrase, it's important that you remember it!

This will create two files:

- `~/.ssh/id_ed25519`: this is your **private** key. It's like a password.
- `~/.ssh/id_ed25519.pub`: this is your **public** key. It's like a username, and can be put on servers (such as GitHub and BluePebble) to authenticate yourself.

## 2. Add the SSH key to the SSH agent

The SSH agent keeps track of SSH keys stored on your computer. Now you have created a new SSH key, you need to add it to the agent.

In your Linux terminal, start the agent by running:

```
eval "$(ssh-agent -s)"
```
Then, add your key to the agent by running:

``` 
ssh-add ~/.ssh/id_ed25519
```

## 3. Upload your public SSH key to GitHub

To upload your public SSH key to GitHub, you need to copy it to your clipboard. Open your public key in VSCode (run `code ~/.ssh/id_ed25519.pub`), and copy the contents.

In a browser, go to [GitHub](https://github.com/) and, if you're not already, login to your GitHub account. 

In the top right corner, click on your profile icon and go to `Settings -> SSH and GPG keys`.

On the right hand side, there will be a green button: `New SSH Key`. Click on this. Enter a title for your key (it can be anything), and paste your public SSH key into the `Key` box. Then click `Add SSH Key`. You might be asked to provide two-factor authentication.

Once you've done this you can confirm that your SSH key is linked to your GitHub. In your terminal, run:

``` 
ssh -T git@github.com
```
If your SSH key has been linked, you will see a message:

```
> Hi USERNAME! You've successfully authenticated, but GitHub does not
> provide shell access.
```
where `USERNAME` should be your GitHub username.

## 4. Setup SSH for logging in to BluePebble

In your homework before week 8, you edited your `~/.ssh/config` file to make it easier to login to BluePebble through VSCode. Now you have an SSH key, you can point to it in your config file, which will mean you don't need to use a password to login to BluePebble. 

Because you have also added your SSH key to your SSH agent, and you are using the same key on GitHub, we can use the SSH agent to authenticate GitHub on Blue Pebble.

To do this, open your `~/.ssh/config` file and update it to look like this:

```
Host bp1
  HostName bp1-login.acrc.bris.ac.uk
  ForwardX11 yes
  User <your bp1 username>
  ForwardAgent yes
  IdentityFile ~/.ssh/id_ed25519

```

Make sure you have saved the changes, and try logging into BluePebble (run `ssh bp1` from your terminal). You should still be asked for a password. This is because you need to put your public key on BluePebble. 

Login to BluePebble with your password, and create a file called `authorized_keys` in the `.ssh` directory by entering `code ~/.ssh/authorized_keys` in the BluePebble VSCode terminal. Copy your public key to this file and save it, then disconnect from BluePebble.

Try reconnecting to BluePebble. You shouldn't need a password. 

You should also be able to use git on BluePebble, because your SSH agent has been forwarded. You can check this by running:

``` 
ssh -T git@github.com
```
in the BluePebble terminal.

## 5. Clone the week 9 repository to BluePebble

Now git is setup on BluePebble, you can clone the repository that contains the material for week 9 teaching. You want to clone it to your `$WORK` partition. In a BluePebble terminal, navigate to your `$WORK` partition.

In a browser, open the repository on GitHub <https://github.com/MRCIEU/conda-hpc-snakemake-example/tree/main>. Fork this repository, so that you have your own copy under your account (hint: click on *Fork* and on the next page set the Owner as your GitHub username). 

Open your fork in the browser, click on the green `Code` button, and copy the SSH url to your clipboard. In the BluePebble terminal, run:

```
git clone <URL>
``` 

replacing `<URL>` with the url from your clipboard.

## 6. Install conda on BluePebble

In your terminal, naviagte to the root directory of this repository. From this directory you can install conda by running:

```
source code/setup/installConda.sh

```

1. You will be asked to review the licence, and accept the terms. **Enter yes**.
2. You will be asked to confirm the installation location. **Press ENTER**.
3. You will be asked if you want to update your shell profile. **Enter no**

Conda should now be installed on your `$WORK` partition. You can activate conda by running

```
source ~/initConda.sh

```