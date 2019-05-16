# pizza-delivery
[![Build Status](https://travis-ci.org/i-karpov/pizza-delivery.svg?branch=development)](https://travis-ci.org/i-karpov/pizza-delivery)
[![codecov](https://codecov.io/gh/i-karpov/pizza-delivery/branch/development/graph/badge.svg)](https://codecov.io/gh/i-karpov/pizza-delivery)

Simple iOS app which showcases app designing best practices and enables you to order pizza in Minsk :)


### Architecture Overview

Keywords: MVP, Flow Coordinator, Layered architecture, DI, Composition Root, UI / Unit Tests.

Codebase is built with layered architecture and MVP. 

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


### Tests / CI

The described architecture allows for highly testable code. The following tests are present:
- Unit tests for Presenters and Flows;
- Integration UI test for core features / flows.

All supporting code required for tests only (fake server, mocks, etc.) is defined in separate targets, so that bundle shipped to production would not contain any tests-related code.
Composition Root (dependencies) is configured separately for production and test targets.

For UI tests there are two layers: classes which represent Scenes and know how exactly to access specific parts of UI, and classes which contain actual tests, which ideally should be written in such a way, that they look like business specification.

Integration tests are currently run on a local fake socket-based web server, which reproduces real JSON-responses copied from real server. This allows to not depend on slight changes in production data (which is updated often, e.g. pizza price can change) and not to affect production server during frequent tests (e.g. placing a real order each time we run test probably is not a good idea), but still such tests involve all layers of codebase, from UI to actual network requests. The only difference is that network requests are sent to localhost instead of production server.

CI with code coverage reports are configured to make sure that codebase is stable.
