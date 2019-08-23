# NearMe
## What it does
NearMe is a sample app that fetches recommended venues for the user. It supports paging the results and a pull to refresh mechanic along with a refining filter that consists of a keyword and radius slider.

## Architecture
The main focus of this project has been the architecture more so than UI. Most of the time is spent on creating a quality base code that supports scaling, modularity, ease of adding new code and testability. Especially the classes under the `Network` folder demonstrates a well written, scalable network layer that allows adding new requests, or even new clients very simple with the help of protocol oriented programming. `APIRequestable` and `APIDataProvider` protocols allow for more `APIClient`s to be created easily. 

The project is built using the MVVM design pattern with network layer injected into the view model. This comes with its own pros and cons that should be discussed and decided per project. In this example, the main focus was to prevent the controller objects from knowing about the models. The network layer could also be put into the controller but then it would have access to the models.

Custom classes such as `ImageDownloader` and  `AsyncImageView` are created to handle image downloading/caching in a simple manner instead of using a 3rd party library.

Another topic of discussion is viewModels creating other viewModels. This is again to prevent the controllers having access to the models and since there was no viewModelProviders or any other layer of the sort in this project, the view models create the next viewModel.

The models are created using the `Codable` protocol. Due to time constraints, safe decoding is not implemented. Instead, properties are kept as optional where they might be missing. Ideally, a safe decoding with default values is preferred since Codable fails the entire object when a non optional property is not found.

## Unit Tests
Simple unit tests are added to test the view models with some error cases.

## Improvements
- Selecting a venue, fetching its details and loading with a map.
- Error handling is done as a basic, but a more detailed one is preferred on a real app to handle all cases gracefully.

## Author
Eren Besel - erenbesel@gmail.com
