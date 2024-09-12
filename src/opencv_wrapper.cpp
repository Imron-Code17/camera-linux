// camera_linux.cpp
#include <iostream>
#include <opencv2/opencv.hpp>
#include <thread>
#include <atomic>
#include <mutex>
#include <vector>

using namespace std;
using namespace cv;

// Thread dan variabel sinkronisasi
std::thread videoThread;
std::atomic<bool> stopFlag(false);
std::atomic<bool> pauseFlag(false);
Mat latestFrame;
std::mutex frameMutex;

// Blok Extern "C" untuk mengekspos fungsi ke C
extern "C" {

// Fungsi untuk memeriksa apakah kamera terhubung
int isCameraConnected() {
    VideoCapture cap(0); // Buka kamera default (device 0)
    if (!cap.isOpened()) {
        std::cerr << "Camera not detected" << std::endl;
        return 0;  // Kamera tidak terhubung
    }
    cap.release();  // Lepaskan sumber daya kamera setelah memeriksa
    return 1;  // Kamera terhubung
}

// Fungsi untuk menangkap frame video
void runVideoCapture() {
    VideoCapture cap(0);
    if (!cap.isOpened()) {
        std::cerr << "No video stream detected" << std::endl;
    } else {
    // Atur properti kamera untuk optimasi
    cap.set(CAP_PROP_FRAME_WIDTH, 640); // Atur resolusi HD
    cap.set(CAP_PROP_FRAME_HEIGHT, 480);
    cap.set(CAP_PROP_FPS, 14); // Atur frame rate

    while (!stopFlag.load()) {
        // Jika dijeda, tunggu hingga dijalankan kembali
        if (pauseFlag.load()) {
            std::this_thread::sleep_for(std::chrono::milliseconds(50));
            continue;  // Lewati iterasi loop saat dijeda
        }

        Mat frame;
        cap >> frame;
        if (frame.empty()) {
            break;
        }

        {
            std::lock_guard<std::mutex> lock(frameMutex);
            latestFrame = frame.clone(); // Clone frame untuk menghindari masalah konkuren
        }

        // Tidur untuk menjaga frame rate dan mengurangi penggunaan CPU
        std::this_thread::sleep_for(std::chrono::milliseconds(69)); // ~14 fps
    }
    cap.release();
    }
}

// Fungsi untuk memulai penangkapan video dalam thread terpisah
void startVideoCaptureInThread() {
    if (videoThread.joinable()) {
        // Thread sudah berjalan
        return;
    }

    stopFlag = false;
    pauseFlag = false;
    videoThread = std::thread(runVideoCapture);
}

// Fungsi untuk menghentikan penangkapan video
void stopVideoCapture() {
    stopFlag = true;
    if (videoThread.joinable()) {
        videoThread.join();
    }

    // Bersihkan frame setelah kamera berhenti
    {
        std::lock_guard<std::mutex> lock(frameMutex);
        latestFrame.release(); // Kosongkan frame untuk memastikan tidak ada frame tersimpan
    }
}

// Fungsi untuk menjeda penangkapan video
void pauseVideoCapture() {
    pauseFlag = true;  // Set flag jeda ke true
}

// Fungsi untuk melanjutkan penangkapan video
void resumeVideoCapture() {
    pauseFlag = false;  // Set flag jeda ke false untuk melanjutkan penangkapan
}

// Fungsi untuk mendapatkan byte frame terbaru
// Pemanggil bertanggung jawab untuk membebaskan buffer yang dikembalikan dengan memanggil freeFrameBytes
uint8_t* getLatestFrameBytes(int* length) {
    // Pastikan pointer valid
    if (!length) {
        std::cerr << "Length pointer is null." << std::endl;
        return nullptr;
    }

    *length = 0;  // Inisialisasi panjang ke 0

    Mat frame;
    {
        std::lock_guard<std::mutex> lock(frameMutex);
        if (latestFrame.empty()) {
            return nullptr;
        }
        frame = latestFrame.clone(); // Clone frame untuk menghindari data races
    }

    // Encode frame sebagai JPEG dengan kualitas lebih rendah untuk mengurangi ukuran
    std::vector<uint8_t> buf;
    std::vector<int> params = { IMWRITE_JPEG_QUALITY, 50 };
    bool encodeSuccess = imencode(".jpg", frame, buf, params);

    // Periksa apakah encoding berhasil
    if (!encodeSuccess || buf.empty()) {
        std::cerr << "Failed to encode image." << std::endl;
        return nullptr;
    }

    *length = static_cast<int>(buf.size());
    // Alokasikan memori dan salin data
    uint8_t* data = new uint8_t[*length];
    if (!data) {
        std::cerr << "Memory allocation failed." << std::endl;
        return nullptr;
    }

    memcpy(data, buf.data(), *length);
    return data;
}

// Fungsi untuk membebaskan buffer frame yang dialokasikan
void freeFrameBytes(uint8_t* data) {
    if (data) {
        delete[] data;
    }
}

}
