# pizza-delivery
[![Build Status](https://travis-ci.org/i-karpov/pizza-delivery.svg?branch=development)](https://travis-ci.org/i-karpov/pizza-delivery)
[![codecov](https://codecov.io/gh/i-karpov/pizza-delivery/branch/development/graph/badge.svg)](https://codecov.io/gh/i-karpov/pizza-delivery)

Simple iOS app which showcases app designing best practices and enables you to order pizza in Minsk :)


### Architecture Overview

Keywords: MVP, Flow Coordinator, Layered architecture, DI, Composition Root, UI / Unit Tests.

Codebase is build with layered architecture and MVP. 

* Presenters depend on Services Layer and Services Layer depends on Data Layer.
* Data Layer is responsible for network requests and serialization/parsing of DTO-structs. DTOs implement Codable protocol.
* Service Layer is responsible for calling/aggregating operations from Data Layer and for mapping between business-models and DTOs.
* MVP Layer uses services for communication with external world (e.g. network requests, access to data storage, etc.)
* Each MVP module is assembled outside the MVP itself -- SceneFactory is in charge of instantiating View and Presenter. 
* Transitioning between view controllers is handled solely by SceneNavigator, which is a dependency of either Presenters or Flows, not Views.
* Navigation/Routing: combinations of approaches is used:
	- by default Presenter depends on SceneNavigatorProtocol and decides where to go next from current scene;
	- for more complex scenarios where navigation flow depends on logic and user input (e.g. some registration multistep wizard, where some step can be skipped depending on user choices/actions) Flows / Flow Coordinators are used. 
Flow depends on SceneNavigatorProtocol and decides where to go depending on result of each MVP-module. MVPs don't know about the actual flow, the are responsible just for processing some relatively small specific amount of data.
Hence flow can modified / reordered without modifying any of MVP-scenes.
* View-layer is implemented by ViewControllers which are instantiated from Storyboards. Each Storyboard usually contains just single view controller.

All dependencies between layers are wrapped by protocols and carefully injected. DI is implemented with Composition Root, which is a single place in the app where dependencies are composed.
