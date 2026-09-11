# LAB1-05 4비트 비교기 - Xsim 사전 시뮬레이션

두 4비트 무부호 입력 `a[3:0]`, `b[3:0]`를 비교하여 `o[2:0]`에 각각 큼, 같음, 작음 결과를 one-hot 형식으로 출력한다.

- RTL: `src/compare_4.v`
- 테스트벤치: `sim/tb_compare_4.sv`
- 검사: 256개 조합, 각 10 ns
- 통과 기준: `LAB1_PASS compare_4 cases=256`, 종료 2560 ns

`LAB1.code-workspace`에서 **터미널 → 작업 실행... → 02 Simulate**를 실행하고 **03 Open waveform**으로 파형을 연다.
