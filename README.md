| Name | ID | Section |
| :--- | :--- | :--- |
| Manuhe Habtamu Mekonnen | UGR/2808/16 | 2 |

# Student Register System (HTTP & Provider)

A clean, premium Flutter application to track student course registry and grade status using **Provider** and standard **HTTP** networking.

## How it's Built (Simply Put)
- **State Management**: Built on standard `ChangeNotifier` (`GradeProvider`) to keep UI in sync reactively.
- **Networking**: Calls standard HTTP endpoints (`GET`, `POST`, `PUT`, `DELETE`) pointing to `dummyjson.com/todos` to simulate real-world CRUD requests.
- **Data Flow**: The UI communicates strictly with the `GradeProvider`, which fetches, inserts, updates, and removes student records via a centralized `ApiService`.

## App Screenshots

| Home Page | Student Registration |
| :---: | :---: |
| ![Home Page](screenshots/home_page.png) <br> Main dashboard showing student list | ![Register](screenshots/register.png) <br> Form to add new student records |

| POST Request | POST Success |
| :---: | :---: |
| ![POST UI](screenshots/POST_request_UI.png) <br> Interface for creating entries | ![POST Success](screenshots/POST_success.png) <br> Confirmation of successful creation |

| PUT Request | PUT Success |
| :---: | :---: |
| ![PUT UI](screenshots/PUT_request_UI.png) <br> Interface for updating entries | ![PUT Success](screenshots/PUT_success.png) <br> Confirmation of successful update |

| PATCH Request | PATCH Success |
| :---: | :---: |
| ![PATCH UI](screenshots/PATCH_request_UI.png) <br> Interface for partial updates | ![PATCH Success](screenshots/PATCH_success.png) <br> Confirmation of successful patch |

| DELETE Request | POST by ID |
| :---: | :---: |
| ![DELETE Success](screenshots/DELETE_request_success.png) <br> Confirmation of record deletion | ![POST by ID](screenshots/POST_byid.png) <br> Fetching/Posting specific records by ID |

