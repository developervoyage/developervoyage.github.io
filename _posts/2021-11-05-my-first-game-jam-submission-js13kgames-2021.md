---
layout: post
title: My first game jam submission - js13kGames 2021
date: 2021-11-05 07:00
author: Johan Wigert
tags: [Game development, js13kgames, Game jam]
permalink: /2021-11-05-my-first-game-jam-submission-js13kgames-2021/
---

A game jam is a competition where participants try to make a video game from scratch within a limited time frame. js13kGames is a JavaScript game jam running once a year since 2012. A fun and extremely challenging component of the js13kGames competition is that the file size is limited to 13 kilobytes. The competition ran between mid-August and mid-September 2021, and in this blog post I'll share my experiences from participating.
<!--more-->

## About js13kGames

The competition is organized by game developer [Andrzej Mazur](https://end3r.com/) from the indie game development studio [Enclave Games](https://enclavegames.com/). This year's edition was the tenth, and the theme was "SPACE". Most game jams have themes open to interpretation, and the js13kGames jam is no exception. The games submitted had different takes on the theme, ranging from keeping distance in public spaces to conquering new planets.

Since the competition has a long history and many participants, the games can be submitted to compete in different categories. I submitted my game in the desktop category, which was the category with the most participants. In total across all categories, there were 223 games submitted.

## My take on the theme

I decided that I wanted to create a simplistic racing game and came up with the following story:

> You are on a space mission and have landed on the moon. You've been exploring the moon with your moon buggy, but you're running out of oxygen! Drive the moon buggy back to the lunar lander before you run out of oxygen while avoiding the rocks and collecting the stars. Will you make it back to the lunar lander in time?

I felt that it tied into the theme nicely and that it would be possible to implement the game within the time frame, and the extremely limited file size.

## Tools and resources

In my day job, I do some development with TypeScript. It would have been allowed to use TypeScript as long as the submitted code would have been the compiled JavaScript code. I, however, decided to keep things simple and use plain JavaScript.

To get something up and running quickly, I decided to go for an established gaming library that had already been used by many previous participants in js13kGames. The library is [kontra.js](https://github.com/straker/kontra), and it is a lightweight JavaScript gaming micro-library, optimized for js13kGames. Since I hadn't used kontra.js previously, I was happy to find that the [documentation](https://straker.github.io/kontra/) was really good. I got started by going through a couple of tutorials and got up to speed quickly.

To simplify the development and build process, I opted for [js13games-boilerplate](https://github.com/wil92/js13games-boilerplate). The project uses kontra.js, Webpack, and Sass. It has some nice features, like zipping up the game and checking the file size. I ended up providing a couple of small contributions to the project as well.

When it came to graphics, I decided that I wanted to go for pixel art graphics. I decided to use [aseprite](https://www.aseprite.org/), which is a popular animated sprite editor and pixel art tool. I ended up creating four sprites: the moon buggy, the lunar lander, a rock, and a star. To compress the PNG files, I used the online service [TinyPNG](https://tinypng.com/). It helped me save about 1 KB.

I wanted to find a nice font for the user interface and ended up using [tinyfont.js](https://github.com/darkwebdev/tinyfont.js). The project is described as the "tiniest possible pixel font for your JS games (<700b zipped, suitable for js13k)". I think it looks great together with the pixel graphics style I went for.

![Moon Buggy Racing splash screen](/assets/2021-11-05-my-first-game-jam-submission-js13kgames-2021/splash-screen.png)

The final piece of the puzzle was adding music and sound effects. I went with a very minimalistic tool called [alphabet-piano](https://github.com/xem/alphabet-piano), which was created by another js13kGames [participant](https://js13kgames.com/entries/lossst-a-snake-in-space) for a previous jam.

## Work process

Many game jams only run for 24 to 72 hours, which is out of the question for me considering having a full-time job and a family. That js13kGames runs for a full month was a prerequisite for me being able to participate. I tried to spend about an hour per night on the game, and I think I ended up putting in about 20-30 hours in total. I tried to achieve one small task every night, and with a very limited game scope, I managed to finish on time.

## Feedback

There is a rigorous feedback process in place for js13kGames. After all the games had been submitted, there was a three-week voting period. Only the participants in the game jam were allowed to vote. The voting took the form of duels, where two games were judged against each other on a number of criteria. To me, it felt like a very fair and fun voting process, and I ended up playing a lot of the other games submitted. Many games are truly amazing! I can hardly believe what can be achieved in only 13 kilobytes. One participant even created a [Quake clone](https://js13kgames.com/entries/q1k3)!

Apart from the peer voting, there were also several experts who judged the games and provided feedback. My game received feedback from three experts.

Lee Reilly:

> Had fun with this one - felt the difficulty settings were just right 👌🏼 Additional levels or repeat plays with more rocks / less time would be a neat addition. Very nicely done! <3

Very positive in my view! With more time, I could definitely have put more effort into expanding the game with additional levels and more varied gameplay.

Raf Mertens:

> Appreciate the addition of a difficulty select! I think a great mechanic would be if you started with much less oxygen and had to collect the stars/oxygen as you go along to survive! It would make a great incentive to collect the stars. Maybe also a boost for the risk takers :) great job on the game though.

I'm really happy about this feedback! I added the difficulty select after having had my wife play-test the game and dying too quickly. The suggestion for improving the game mechanic is also great.

Michelle Mannering:

> love the backstory - 8 bit music! Love it - doesn't appear to be working; there was nothing to drive on... only black screen. Tried in Chrome and Brave

Great that the music was appreciated since I had some difficulties in implementing it! Regarding the black screen, it was by design and not a bug. However, I did consider making a background but ran out of time.

The top 100 games in each category were ranked, but my game didn't make it into the top 100 this year. I'm still happy with the feedback I received, and most of all I'm happy that I actually managed to finish the game in time.

## Play the game yourself!

If you want to play the game yourself, please head over to the official game jam site:

[![Moon Buggy Racing screenshot](/assets/2021-11-05-my-first-game-jam-submission-js13kgames-2021/moon-buggy-racing.png)](https://js13kgames.com/entries/moon-buggy-racing)

If you would like to have a look at the source code, it can be viewed on [GitHub](https://github.com/jwigert/moon-buggy-racing).

## Conclusion

This was my first game jam participation, and I'm very happy that I decided to participate. The feedback I received was positive, and I really enjoyed creating my own game as well as playing the games submitted by the other participants.

The js13kGames game jam is run very professionally, and I can definitely recommend participating next year! You should also try out some of the games! A good starting point is the list of [winners](https://js13kgames.com/#winners).

Happy game jamming!
