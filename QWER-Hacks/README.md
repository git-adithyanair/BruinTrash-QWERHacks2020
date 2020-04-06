# BruinTrash (QWER-Hacks 2020)

## Description

Do we really know what types of waste go into different trash bins?

Chips packets in landfill? Aluminium foil in recycling?

With BruinTrash, you no longer need to guess! This iOS application, developed by three students at UCLA during QWER-Hacks 2020, aims to solve that issue by letting the user click a picture of the trash item they want to get rid of. The app then tells the user which bin to throw the trash in. With a simple interface, this app can be used by just about anyone.

Check out our DevPost writeup for more information: https://devpost.com/software/bruintrash

## How it works

The app makes use of Google Cloud's Vision API to identify different items in the picture the user takes by assigning labels. The app uses these labels and a prioritizing algorithm to compare it to labels stored in a Google Cloud Firestore database already populated with different items segregated according to trash type to determine what type of trash is in the picture.

## Team members

* *Adithya Nair (GitHub: **@git-adithyanair**)*
* *Aritra Mullick (GitHub: **@aritramullick**)*
* *Sanya Srivastava (GitHub: **@sanya29**)*
