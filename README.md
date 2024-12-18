# GesturEase  

**GesturEase** is a Flutter-based mobile application designed to make learning and recognizing Indian Sign Language (ISL) accessible and engaging. It integrates real-time gesture recognition, text translation, speech output, and learning resources to bridge communication gaps and promote inclusivity.  

## Key Features  

### 1. **Sign Recognition**  
- Recognizes ISL gestures using the device's camera or uploaded images.  
- Provides accurate gesture predictions using advanced machine learning models.  

### 2. **Text Translation**  
- Supports multiple languages through the Google Translator API.  
- Translates input text into other languages for seamless communication.  

### 3. **Learning Resources**  
- Offers curated links to YouTube videos, online courses, and ISL dictionaries.  
- Empowers users to improve their ISL skills with engaging educational materials.  

### 4. **Speech Output**  
- Converts recognized ISL gestures into speech using the Flutter TTS (Text-to-Speech) library.  

## Backend Overview  

### Framework  
- **FastAPI** is utilized to create efficient and scalable API endpoints.  

### Machine Learning Models  
- Pre-trained models built with TensorFlow and scikit-learn power gesture recognition.  

### Image Processing  
- **Pillow** and **OpenCV** preprocess images before feeding them into the ML models.  

### Key Endpoints  
- **/predict/**: Accepts an image, processes it, and returns the recognized gesture.  
- Additional endpoints are planned to support future features.  

## Future Enhancements  
- Expanding gesture vocabulary for broader ISL coverage.  
- Adding offline support for improved accessibility.  
- Integrating advanced voice and regional language support.  

---  
*GesturEase: Bridging communication gaps and making ISL learning accessible for all.*  
