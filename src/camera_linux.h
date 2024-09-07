#include <stdint.h>  

#ifdef __cplusplus
extern "C" {
#endif
         
void startVideoCaptureInThread();
void stopVideoCapture();
void pauseVideoCapture();
void resumeVideoCapture();

uint8_t* getLatestFrameBytes(int* length); 
    
#ifdef __cplusplus
}
#endif


