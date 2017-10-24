# Microblog

[![Build Status](https://travis-ci.org/Devlus/microblog.svg?branch=master)](https://travis-ci.org/Devlus/microblog)

My site can be found at: microblog.devonherlitz.solutions

In addition to the lecture notes, I modified the sample code provided in:
https://hexdocs.pm/distillery/running-migrations.html#migration-module
which was recommended in the lecture notes.

## REPO
https://github.com/Devlus/microblog

## Homework 5
**Preface:** I relied heavily on Nat's notes and code for setting up passwords. I changed things as needed, but generally what he wrote with us in class was sufficient for my needs. 

I also followed this tutorial for setting up image uploads:\
https://medium.com/@Stephanbv/elixir-phoenix-uploading-images-locally-with-arc-b1d5ec88f7a

What I did:
I added passwords, ssl certs, Markdown, and Searching by terms.

I also removed unused routes, and hid some screen that shouldn't have been presented to the user.

The passwords are pretty straight forward, click the login button after creating an account. And enter your credentials into the super fancy modal that opens. I am not encrypting with argon because my server was having trouble compiling the C it relies on so I am using pbkdf2 instead.

Markdown is rendered and sanitized. Just create a post and watch it go.

Searching is based only on message content, and is a `contains` filter for the search term.

ssl was just cert bot magic.

Images only work locally, which is apparenly okay according to:\
https://piazza.com/class/j61milf8rku5pe?cid=265


## Homework 4
Added ability for posts to be broadcasted to anyone looking at the page of the use who posted, and automatically to the pages of their followers.
I am certain that my code is wildly inefficient but it seems to works.

Travis config was taken from Nat's notes, with the working config taken from https://stackoverflow.com/a/30190186

I looked at the pattern that Nat followed to fix his tests to fix mine, no code was taken, but the general idea of creating a function for setting up the data was used.

## Homework 3
Liking has been implemented in the microblog. To like a post, login, and go to your profile, or someone else's profile and click the paw on the top right of a post. Once the paw is clicked on, the number next to the paw will be updated as soon as the server is done processing the like. Your handle will also be rendered in the popover list that is presented when you hover over the paw. The server will not allow you to like a post multiple times, just once, but it will gracefully handle the attempt.

This is how I planned on implementing likes from the beginning, so I would say that it was implemented successfully, at least to my vision.

### Scripts
I have 2 scripts to aid in deployment. `buildDep` bundles and moves my deployment to my server. and `unpack` untars, runs migrations, and removed the old tar.


## Homework 2
When the page loads, a list of users should be displayed to the un-logged in user.
If the does not already have an account, they can click "New User" in order to create a new user.\
Once a user exists, you can type the email address for that user in the login box on the top (far) right of the screen.

After login in the user is taken to their profile. They can enter new posts in the box in the right hand side column. Additionally, you can return to your profile page at anytime by clicking the paw on the nav-bar.

A User can browse other user's profiles by clicking "Explore" in the nav bar. On another user's page, you can click stalk in order to follow their meows.

Meows from people you are stalking will be displayed now on your own profile.
You can also browse a list of everyone you are stalking by clicking the "stalking" in the nav bar. You can also unfollow people from here.


When you are done, you can log out by clicking the big red log out button.


The Stalk button doesn't get hidden after click, so you can follow someone multiple times, this will be fixed in the future.

Server has been restarted and continues to show site without intervention.



