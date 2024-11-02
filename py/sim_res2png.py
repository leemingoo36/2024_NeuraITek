import numpy as np
from PIL import Image

# 텍스트 파일 경로 설정
file_path = 'ISA_simulator_result.txt'

# 텍스트 파일에서 데이터를 읽고, 숫자만 추출하여 배열로 변환
with open(file_path, 'r') as file:
    # 파일의 모든 데이터를 읽고, 대괄호와 불필요한 문자를 제거
    data = file.read().replace('[', '').replace(']', '').replace(',', '').split()
    # 문자열 리스트를 정수 리스트로 변환
    pixel_values = list(map(int, data))

# 픽셀 값의 개수 확인 후 512x512 형태로 변환
if len(pixel_values) != 512 * 512:
    raise ValueError("데이터가 512x512 이미지에 맞지 않습니다.")

# 픽셀 값을 512x512 numpy 배열로 변환
pixel_array = np.array(pixel_values, dtype=np.uint8).reshape((512, 512))

# 배열을 이미지로 변환하고 저장
image = Image.fromarray(pixel_array, 'L')  # 'L'은 흑백 이미지를 의미
image.save('SIM.png')
image.show()  # 이미지를 표시
