# Questions about you

I wouldn't call it "about you" (there is much more to "you").

As a candidate (and not just as a candidate ;) ) I'd think "wow, there is some disbalance there".
  

We'd like to get to know you a bit better, so here are some questions about our favorite topic: writing software. We look forward to talking more about this with you!

  

## Favorite Languages And Tools  

> Which are your favorite languages and tools for building things? Please explain your experience and why you like them.

***add your answer here***
  

## Code Quality

> What for you is the most important for writing quality code?
  
***add your answer here***
  
  
## Favorite Code

> Which are your favorite open-source projects and packages?

***add your answer here***


## Role-Models

> Do you have any programming role-models? Do you have any favorite book(s) on software? Who, which ones, and why?

***add your answer here***

  
## Remote Work  

> We operate 100% remotely, which is a much different way of working than jobs you may have had. What are the greatest challenges of working remotely in your opinion?

***add your answer here***

  
---


# Questions about programming

We'd like to see how you approach and think about problems. Don’t worry if the perfect answer doesn’t come to you right away: we’re interested in seeing problem-solving rather than “best” answers.
  

## There can be only one

> How would you improve this code? Why do your suggestions improve things?

>

> ```elixir

> defmodule Users do

> alias MyApp.Users.User

>

> def add_user(user_changeset) do

> email_address = Ecto.Changeset.fetch_change!(user_changeset, :email_address)

>

> case Repo.one(from u in User, where: u.email == email_address, select: u.email) do

> nil -> Repo.insert(user_changeset)

> %User{} -> {:error, :already_exists}

> end

> end

>

> end

> ```

  
There is potential race-condition here.
Use unique index (assuming this code sits on top of SQL DB) and just insert (well, try to insert) user_changes.
(And more bla, bla, bla, if I feel need to impress you.)


## Show me what you’ve got

> We've deployed a simple company blog where employees can write posts related to the company, its product, engineering practices, and so on.

>

> Blog posts are hidden from the public while they are written, reviewed, and polished. Once they're just perfect, they get published to blog where readers can then feast their eyes on the new content.

> In its current form, the blog doesn't track publication date and the posts are simply displayed by insertion timestamp. But faithful readers have complained they've been missing blog posts: they check the index page every day to ensure the last blog post they read is a the top of the list. If yes, they assume no new content is available.

>

> Why could users possibly be missing new content that is getting published?

>


Lets assume that post A is created before post B but A spends longer in review, so when A is eventually published it shows up beneath B.


> In addition, users have requested to be able to filter content by subject (company announcements, engineering, etc.): currently, there's no such functionality as all posts are simply considered "content".

>

> One of the engineers has decided to solve both problems by writing a database migration that:

>

> * introduces a nullable "published_at" column

> * introduces a non-nullable "topic" column

>

> This engineer is known to gloss over details in his solutions and this has lead to issues in production in the past. What should you be verifying when reviewing his work?


"topic" column has to have default value set, if it is to be applied on not-empty table.
But then what would be good default topic?
This field should probably be introduced as null-able, manually backfilled and then converted to not-null-able.

"published_at" column probably need to be back-filled after creation for all already published posts.
Removal of column "published" (assuming there is one) should be considered after the migration, together with code change which will treat "published_at" as indicator of "if post is published" (this has to be done in multiple deployments because bla, bla, ...).  

Introducing those two changes in separate PRs and separate deployments might be good idea.

  
## Avatar: the last data-bender  

> A junior engineer has implemented a "user avatar" feature where users can upload a small image to accompany their username. Unfortunately, this junior engineer has persisted the image to disk instead of to the centralized storage repository (think AWS S3). When the user uploads their image, they can indeed see their new avatar image.

>

> But if they click on the "edit" button, it doesn't always work properly. What could possibly be going wrong?

  
Service is load balanced (there are multiple server instances).
One has the avatar, the rest of them don't.
Edit action is sometimes served by the "lucky" server (1/n times) and sometimes ((n-1)/n times) by "not lucky" ones (unless session is pinned but the issue would manifest sooner or later anyway).


## It’s always sunny with cloud computing

> The (fictional, don't worry) company has been having issues when dealing with sudden load spikes. Engineers are looking into this, but in the meantime a cloud solutions salesperson informed us that our account offers automated load-based scaling. Could that solve all our problems?

>


Depends on many things:
- Where exactly are those spikes happening and how do they impact the system
- Can that part of the system be simply scaled up or there are limits and/or unexpected consequences (e.g. connection pool limit or overload of some other subsystem or maybe it is too expensive or ...)
- How fast spikes happen: can auto-scaling react fast enough
- ...
  

> Let's say the engineers located the problem: the database can't deal with load spikes and starts to get overwhelmed. As database requests take longer and longer to fulfill, web requests (both browser requests and API calls) start timing out. For the foreseeable future, we won't be in a position to improve database performance or resilience (it's already been worked on, and improving the situation will require engineering effort and financial investments we're not in a position to make at this time). What are other avenues we can investigate to attenuate the impact sudden surges in requests have on the entire system?

  
Depending on the nature of the load:
- Rate limiting if the spike is caused by relatively small number of callers with considerable number of requests each.
- Request throttling if a spike is caused by huge number of callers initiating small number of requests each (ideally single request per caller per period of time).

It might be a good idea to place a circuit breaker in DB client. So that the system can recover if overload happens even with throttling/rate-limiting in place.

(If I'm candidate, I would probably describe/discuss each of those techniques.)

  
## Have you tried turning it off and on again?

> We're writing an application to handle the scheduling of IT support staff: users have a phone number they can call when they have an IT-related issue. Naturally, the phones have to be manned: at least one person is scheduled for phone duty every day, but usually there are 2 people scheduled (redundancy, yay!). But naturally, life happens and people need to change shifts, take time off, and so on.

>

> There have been cases where some days ended up without anybody on phone duty because both people on call duty were able to take time off for the same shift (only 2 people were scheduled for that shift). This shouldn't be possible: before allowing an employee to take the day off, the system checks that at least one other employee is scheduled for that day. How could this have happened? How would you suggest getting this fixed so that there's always someone on phone duty?

  
Race. Both employees request a day off at the (roughly) same time.

This can be long discussion but I can't write all that:
- if the system is backed by SQL DB -> use DB transactions
- if the system is eventually-consistent (distributed system and/or NOSQL DB), depending on the situation choose synchronization method: RAFT (heavy artillery), distributed saga, manually create mutex within the service, introduce SQL DB, ...
