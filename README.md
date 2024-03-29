# Social_Distancing_App

# Introduction

Augmented Reality (AR) is one of the technologies that allow humans to enhance their perceptual abilities. It facilitates functioning in the world and allows us to experience reality more fully. It involves using a physical medium to present additional objects from the virtual world in the real world (Chang et al., 2014).  AR also allows users to interact with virtual objects, by moving it or changing the size of them wit the GUI (Afsoon, Taha, and Peyman, 2021). Augmented reality conveys information simply and quickly to humans. 

AR finds a wide range of applications. One of these is the use of AR as a tool to improve vision in people with very profound vision loss. Using AR glasses with an app that performs contour detection, allows people to see the world much more clearly. They also make it easier for visually impaired people to navigate rooms with numerous obstacles. Respondents reported no significant discomfort with wearing the glasses (Park and Howard, 2012).

Augmented reality can also be a useful tool for crisis management during a pandemic such as COVID-19, with applications in training medical students on the transmission and spread of the virus. Using AR for training has been found to increase the participant's attention level, resulting in faster learning (Afsoon, Taha, and Peyman, 2021) Additionally, it can help doctors (wearing AR glasses with good audio and video quality) to interact with patients or quickly consult information with other clinicians. 

Augmented reality is also being used as part of work in the construction sector.  It  allows for creation of safety systems that notify workers in advance of impending dangers. Using AR goggles during work on motorways, it is possible to present the edges of objects in real-time and classify vehicles at a distance. The user is alerted to potential hazards in their surroundings and can react quickly minimizing the risk of an accident (Sabeti, Shoghli, Baharani, and Tabkhi, 2021). 

Real-time distance determination can also be a useful component of social contact prevention during a pandemic. It allows the creation of a program to facilitate the maintenance of a safe (1.5m) social distance aimed at minimizing the risk of contracting a virus. Moreover, the project attempts to create a program that, using face detection, checks the distance between people and communicates when this distance is exceeded. The information is transmitted in real-time to the recipient via a tablet or a phone. An additional function of the program is the detection of tags and the notification when the user enters a dangerous space. 

The program was created in language Processing 3.

# Project components:
Libraries:
- OpenCV - a library for image processing, including face recognition;
- controlP5 - library used to design the GUI;
- processing.video - library for handling video, in this project for capturing live video from a camera;
- java.awt - a library for image editing;
- jp.nyatla.nyar4psg - a library for creating an AR application.

Classes:
- for marker recognition - nya;
- for buttons - cp5;
- for a video file (capturing a live image from a camera) - video.
- for face recognition - OpenCV
- for face tracking and drawing a square used to calculate the distance of face people.

External files:
graphic files - marker, menu background files, Biohazard warning sign.

The app includes a graphical user interface on the start screens, where the menu is located, and on the individual scenarios. The application supports two scenarios:
recognition of the social distance between people;
recognition of markers to warn of danger.

In both scenario: "recognition of the social distance between people", the app recognizes faces, assigns them a marker in the form of a cube, and shows the distance between people. The cube marker appearing above the recognized face can take 2 forms:
- red filled - the person is too close;
- blue edges - the person is at the correct distance or has been added to exceptions using the Add exception button.

Two options are possible:
- the scenario 1: recognition of the distance between the camera and the other person;
- the scenario 2: recognizing the distance between a third person.
Use the Start/Stop, Distance, and Add exception buttons to navigate this section.

Below you can see the Menu view of the application.

![Dystans_Main](https://user-images.githubusercontent.com/79842403/210446588-3c8cfb58-53fe-45d9-9f44-1355bad869dc.PNG)

Sources:
- Afsoon, A., Taha, S.-S. i Peyman, R.-H. (2021). Applications of virtual and augmented reality in infectious disease epidemics with a focus on the COVID-19 outbreak. Informatics in medicine unlocked, str. 100579.
- Chang, K.-E., Chang, C.-T., Hou, H.-T., Sung, Y.-T., Chao, H.-L. i Lee, C.-M. (2014). Chang, K.-E., Chang, C.-T., Hou, Development and behavioral pattern analysis of a mobile guide system with augmented reality for painting appreciation instruction in an art museum. W Computers & Education (strony 71, 185-197).
- Park, C. H. i Howard, A. M. (2012, marzec). Real world haptic exploration for telepresence of the visually impaired. In Proceedings of the seventh annual ACM/IEEE international conference on Human-Robot Interaction, strony 65-72.
- Sabeti, S., Shoghli, O., Baharani, M. i Tabkhi, H. (2021). Toward AI-enabled augmented reality to enhance the safety of highway work zones. Feasibility, requirements, and challenges. Advanced Engineering Informatics,, str. 101429.
