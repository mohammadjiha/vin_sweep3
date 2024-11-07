# vin_sweep

VIN Sweep is a powerful Flutter app that allows users to retrieve comprehensive details about any vehicle by scanning or entering its Vehicle Identification Number (VIN). This app helps users make informed decisions when purchasing or inspecting vehicles by providing valuable information such as mechanical history, parts authenticity, and ownership details.

## Key Features

- **Multi-Input Options:**
    - **Scan VIN** using the device camera.
    - **Manual Entry** of VIN.
    - **Image Upload** for VIN recognition and information extraction.

- **Detailed Vehicle Information:**
    - **Mechanical and Historical Data**: Check the condition of engine, brakes, and other components, along with past accident history and maintenance records.
    - **Parts Authenticity**: Verify if vehicle parts are original.
    - **Ownership and Mileage**: Access information about previous owners and mileage.

- **User Authentication** for secure access.

## Technologies and Libraries

- **State Management**: GetX
- **Responsive Design**: Sizer
- **Localization**: Flutter Localization
- **API Integration**: RESTful APIs for retrieving vehicle data
- **User Interface & UX**: Intuitive and responsive design
- **Local Storage**: Shared Preferences for storing user data locally

### Libraries Used

| Library                  | Purpose                                   |
|--------------------------|-------------------------------------------|
| `sizer`                  | Responsive layouts                        |
| `get`                    | State management                          |
| `flutter_localization`   | Localization support                      |
| `google_fonts`           | Modern typography                         |
| `device_preview`         | Preview app on multiple devices           |
| `fluttertoast`           | Display toast messages                    |
| `flutter_spinkit`        | Loading animations                        |
| `otp_text_field`         | OTP input fields                          |
| `convex_bottom_bar`      | Bottom navigation bar                     |
| `url_launcher`           | Open URLs                                 |
| `flutter_speed_dial`     | Floating action button                    |
| `google_ml_kit`          | Machine learning for VIN recognition      |
| `camera`                 | Access device camera                      |
| `google_mlkit_text_recognition` | Text recognition in images          |
| `lottie`                 | Animated illustrations                    |
| `buttons_tabbar`         | Tab bar with buttons                      |
| `shared_preferences`     | Persistent storage                        |
| `http`                   | HTTP requests for API interaction         |

## Getting Started

### Prerequisites

- **Flutter SDK**: Ensure Flutter SDK is installed on your machine.
- **API Access**: Update the API URLs and keys in the code as needed for vehicle data retrieval.

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/mohammadjiha/vin_sweep3.git
   cd vin_sweep3