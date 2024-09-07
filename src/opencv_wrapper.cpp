#include <iostream>
#include <opencv2/opencv.hpp>
#include <thread>
#include <atomic>

using namespace std;
using namespace cv;
    
std::thread videoThread;
std::atomic<bool> stopFlag(false);
std::atomic<bool> pauseFlag(false);
Mat latestFrame;
                
// Extern C block to expose the function to C
extern "C" {
    // Function to capture video frames
    void runVideoCapture() {
        VideoCapture cap(0);
        if (!cap.isOpened()) {
            cout << "No video stream detected" << endl;
            system("pause");
            return;
        }

        while (!stopFlag.load()) {
            // If paused, wait until pause is disabled
            if (pauseFlag.load()) {
                std::this_thread::sleep_for(std::chrono::milliseconds(30));
                continue;  // Skip the current loop iteration if paused
            }

            cap >> latestFrame;
            if (latestFrame.empty()) {
                printf("Frame is Empty");
                break;
            }

            std::this_thread::sleep_for(std::chrono::milliseconds(30));
        }
        cap.release(); 
    }

 
    void startVideoCaptureInThread() {
        stopFlag = false;
        pauseFlag = false;
        videoThread = std::thread(runVideoCapture);
    }

    void stopVideoCapture() {
        stopFlag = true;
        if (videoThread.joinable()) {
            videoThread.join();
        }
    }

    void pauseVideoCapture() {
        pauseFlag = true;  // Set pause flag to true
    }

    void resumeVideoCapture() {
        pauseFlag = false;  // Set pause flag to false to resume capture
    }

    uint8_t* getLatestFrameBytes(int* length) {
        // Ensure the pointer is valid
        if (!length) {
            cout << "Length pointer is null." << endl;
            return nullptr;
        }

        *length = 0;  // Initialize length to 0
        
        if (latestFrame.empty()) {
            printf("Frame Empty");
            return nullptr;
        }

        // Encode the frame as JPEG
        vector<uint8_t> buf;
        bool encodeSuccess = imencode(".jpg", latestFrame, buf);

        // Check if encoding was successful
        if (!encodeSuccess || buf.empty()) {
            cout << "Failed to encode image." << endl;
            return nullptr;
        }
        
        *length = static_cast<int>(buf.size());
        // Allocate memory and copy data
        uint8_t* data = new uint8_t[*length];

        if (!data) {
            cout << "Memory allocation failed." << endl;
            return nullptr;
        }
        
        memcpy(data, buf.data(), *length);

        return data;
    }
}
