# Welcome to Photo Finder README 

### Summary

<img src="https://github.com/user-attachments/assets/7a58a159-269f-4250-b5b1-ab28ab282395" alt="Screenshot_1" width="200">
<img src="https://github.com/user-attachments/assets/6086bbac-4550-4517-9c68-58b98de0d194" alt="Screenshot_2" width="200">
<img src="https://github.com/user-attachments/assets/3c720092-2446-40bd-96ba-236018e27887" alt="Screenshot_3" width="200">


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

* User Experience: From the start, the look and feel of the app was my main area of focus. We chose to prioritize this because I believe a user's first impression of an application is shaped by how smooth and useful the experience is.

* Easy Search: I enhanced the experience by allowing users to search for a specific photos. We focused on this feature to add value to the user experience, making it easier and quicker for users to find the content they want to see.

* Caching and Image Storage: We wanted to improve how users interact with images. Nothing is more frustrating than an app freezing due to background processes the user isn't aware of. To address this, we load images only when needed and store them on the device to prevent unnecessary additional requests for previously viewed images.

* Project Structure & Architecture: As a developer accustomed to working with peers, I know how easy it is to overlook clean structure and proper separation of concerns in the rush of development. From the start, I prioritized a SOLID + DRY approach, ensuring each layer is well-separated based on its responsibility.

* Look and Feel: As a user, I appreciate having the option to use an app in dark mode, so I made sure to include that feature for a more customizable experience.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent almost three development days on this project (around 6-8 hours each day). I allocated the time as follows:

1. Project Setup and Architecture (20%)
I began by defining the code layers, folder structure, and separation of concerns. The business models and networking layer were also established at this stage. We verified a successful connection to the app’s remote resources and ensured the business layer was properly integrated.

By setting up a solid foundation and having clear project requirements from the start, I was able to streamline this step and avoid unnecessary delays.

2. View Layer Implementation (30%)
I first created a plain UI using mock data, defining and building all reusable views. My primary focus was on user experience, ensuring:

Smooth keyboard interactions
Optimized scrolling
Efficient image caching
Local storage for images
Due to the emphasis on UX, this phase required the largest time investment.

3. ViewModel Layer Implementation (30%)
Since the project requirements were well-documented, I encountered no major challenges in this layer. We handled all possible ViewModel states, ensuring the UI correctly bound and updated based on data changes.

This step also involved connecting the remote models to the ViewModel and verifying they were properly rendered in the UI.

4. Testing (10%)
Most of the testing work was already covered in the ViewModel implementation phase, as we structured tests based on use cases. In this step, we ensured that all use cases returned the expected data in the correct format.

5. Documentation, Code Cleanup, and Refinement (10%)
Every app has room for improvement. In this final step, we reviewed functionality, performed bug fixes, and made refinements based on testing feedback. We ensured the app behaved as expected before finalizing the project.


### Trade-offs and Decisions

1. Favorite Button
   Initially considered adding a favorite button to allow users to save your favorite photos. However, without a clear data persistence strategy (local storage or backend sync), implementing this feature now would introduce unnecessary complexity.

2. Offline Support
  Implementing full caching and sync mechanisms adds significant overhead and compromises the project deliverability

3. Optimizing for slow connections:
   Adding skeleton loader/shimmering effect for the image loading would require additional performance considerations. That's why we focus on the core UI functionality first.

### Weakest Part of the Project

I do think there's few part of the project that could be improved such as: 

* Accessibility: We should always take in mind all the possible user base
* UI Is very plain and lacks features that could make the search easier, such as tagged photos, favorites or tabs.
* Lack of offline support (Cached response)

### Additional Information

Yes — there are two important notes to highlight:

API Key Exposure
Due to project restrictions, the API_KEY is defined in a file as a constant. In a production environment, this approach is not recommended, as the key can be extracted through reverse engineering and potentially abused by malicious actors.
As developers, we could define a roadmap to improve this by proxying requests through a backend, which would prevent exposing sensitive values directly in the app.

Flickr API and Unsafe Content
The Flickr API is public and widely used by many users to upload photos. Unfortunately, users often upload content that may be unsafe without tagging it appropriately.
As a result, even when using the safe_search parameter, the API may still return inappropriate content. This could lead to the app being rejected during App Store review for not properly filtering content for the target audience.
More importantly, it's not appropriate to risk exposing underage users to such content. Filtering or additional content moderation should be considered before production release.
