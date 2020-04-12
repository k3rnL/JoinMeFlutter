# <img src='https://storage.googleapis.com/joinme-2aa7a.appspot.com/logo.png' height='40' alt='Redux Logo' aria-label='redux.js.org' /> JoinMe

# JoinMeFlutter

# <img src='https://storage.googleapis.com/joinme-2aa7a.appspot.com/87493379_2638298063072453_7275545694570545152_n.jpg' height='250' alt='Redux Logo' aria-label='redux.js.org' /> <img src='https://storage.googleapis.com/joinme-2aa7a.appspot.com/87499390_335287354073467_5132856063296536576_n.jpg' height='250' alt='Redux Logo' aria-label='redux.js.org' />

JoinMe is an social application to help people to create a meeting point by just simply drop a point on the map !

The users are able to invite in a party (aka. meeting point) their friends from their contact list.
A party is described by a name,  description, a point on a map, it could be an address or a GPS point and a member list.

On the party page, the user can just click on a button to go to the party using google maps !

# Get the app !

You can download the apk for android on this [![Codemagic build status](https://api.codemagic.io/apps/5e46ad835420555db3ca6178/5e46ad835420555db3ca6177/status_badge.svg)](https://codemagic.io/apps/5e46ad835420555db3ca6178/5e46ad835420555db3ca6177/latest_build)

# Requirements

- Dart version => 2.7.0

- Flutter version => 1.12.13

- Java version => 1.8

# Development mode

- flutter packages get

- flutter build android

- flutter build ios

# Build project

The project uses a continuous integration platform called Codemagic.
The project has 2 differents CI : 

- When in master branch the project will be build in release and debug

- When in dev branch the project will be build in debug
