# 🚀 Neovim 설정 완전 가이드

> Python(PyTorch) 및 Svelte(SvelteKit) 개발에 최적화된 Neovim 설정

## 📋 목차

- [기본 설정](#기본-설정)
- [키맵 정리](#키맵-정리)
- [플러그인별 사용법](#플러그인별-사용법)
- [Python 개발 워크플로우](#python-개발-워크플로우)
- [Svelte 개발 워크플로우](#svelte-개발-워크플로우)
- [문제 해결](#문제-해결)

---

## ⚙️ 기본 설정

### 리더 키
- **리더 키**: `<Space>` (스페이스바)

### 기본 옵션
- **탭 크기**: 2 스페이스 (expandtab)
- **줄 번호**: 표시 (absolute)
- **스왑 파일**: 비활성화

---

## ⌨️ 키맵 정리

### 🧭 기본 내비게이션
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<C-h/j/k/l>` | 창 이동 | Vim 창 간 이동 |
| `<leader>h` | 하이라이트 끄기 | 검색 하이라이트 제거 |
| `<leader>n` | 줄 번호 토글 | absolute ↔ relative 전환 |

### 🔍 검색 및 파일 관리 (Telescope)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<leader>ff` | 파일 찾기 | 현재 디렉토리에서 파일 검색 |
| `<leader>fr` | 최근 파일 | 최근 열었던 파일 목록 |
| `<leader>fs` | 문자열 검색 | 프로젝트 전체 문자열 검색 |
| `<leader>fc` | 커서 단어 검색 | 커서 아래 단어로 검색 |
| `<leader>fb` | 버퍼 목록 | 열린 버퍼 목록 |
| `<leader>fh` | 도움말 검색 | Vim 도움말 검색 |
| `<leader>fk` | 키맵 검색 | 설정된 키맵 검색 |

### 🔧 LSP (Language Server Protocol)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `K` | 호버 정보 | 심볼 정보 표시 |
| `<leader>gd` | 정의로 이동 | 함수/변수 정의로 이동 |
| `<leader>gr` | 참조 찾기 | 심볼 사용처 찾기 |
| `<leader>ca` | 코드 액션 | 코드 수정 제안 |
| `<leader>gf` | 포맷팅 | 코드 포맷팅 |
| `<space>rn` | 이름 변경 | 심볼 이름 변경 |
| `<leader>fd` | 현재 파일 진단 | 현재 파일 오류/경고 |
| `<leader>fD` | 전체 진단 | 프로젝트 전체 진단 |

### 🚨 진단 및 문제 해결 (Trouble)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<leader>xx` | 진단 토글 | 전체 진단 목록 |
| `<leader>xX` | 버퍼 진단 | 현재 버퍼 진단 |
| `<leader>cs` | 심볼 목록 | 문서 심볼 목록 |
| `<leader>cl` | LSP 목록 | LSP 정의/참조 목록 |
| `<leader>xL` | 로케이션 리스트 | Location List |
| `<leader>xQ` | 퀵픽스 리스트 | Quickfix List |

### 🐛 디버깅 (nvim-dap)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<F5>` | 디버깅 시작/계속 | 디버그 세션 시작 |
| `<F10>` | 스텝 오버 | 한 줄씩 실행 |
| `<F11>` | 스텝 인투 | 함수 내부로 진입 |
| `<F12>` | 스텝 아웃 | 함수에서 나오기 |
| `<leader>b` | 브레이크포인트 | 중단점 토글 |
| `<leader>B` | 조건부 브레이크포인트 | 조건부 중단점 |
| `<leader>dr` | REPL 열기 | 디버그 REPL |
| `<leader>du` | UI 토글 | 디버그 UI 토글 |
| `<leader>de` | 평가 | 표현식 평가 |

### 🧪 테스트 (Neotest)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<leader>tt` | 가까운 테스트 실행 | 커서 위치 테스트 실행 |
| `<leader>tf` | 파일 테스트 실행 | 전체 파일 테스트 |
| `<leader>td` | 테스트 디버깅 | 디버그 모드로 테스트 |
| `<leader>ts` | 테스트 요약 | 테스트 결과 요약 |
| `<leader>to` | 테스트 출력 | 테스트 출력 보기 |
| `<leader>tS` | 테스트 중지 | 실행 중인 테스트 중지 |
| `]t` / `[t` | 실패한 테스트 이동 | 다음/이전 실패 테스트 |

### ⚡ 빠른 이동 (Flash)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `s` | 점프 | 화면 내 빠른 점프 |
| `S` | Treesitter 점프 | AST 기반 점프 |
| `r` | 원격 점프 | 오퍼레이터 모드 점프 |
| `R` | Treesitter 검색 | AST 기반 검색 |

### 🔄 Git (GitSigns)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `]c` / `[c` | Git hunk 이동 | 다음/이전 변경사항 |
| `<leader>hs` | Hunk 스테이지 | 변경사항 스테이지 |
| `<leader>hr` | Hunk 리셋 | 변경사항 되돌리기 |
| `<leader>hp` | Hunk 미리보기 | 변경사항 미리보기 |
| `<leader>hb` | Blame 보기 | Git blame 정보 |
| `<leader>tb` | Blame 토글 | 라인별 blame 토글 |
| `<leader>hd` | Diff 보기 | Git diff 보기 |

### 📝 텍스트 편집 (Mini.surround)
| 키맵 | 기능 | 설명 |
|------|------|------|
| `ys` | 감싸기 | 텍스트를 문자로 감싸기 |
| `ds` | 감싸기 제거 | 주변 문자 제거 |
| `cs` | 감싸기 변경 | 주변 문자 변경 |

### 🎨 포맷팅 및 린팅
| 키맵 | 기능 | 설명 |
|------|------|------|
| `<leader>mp` | 수동 포맷팅 | 파일 포맷팅 |
| `<leader>l` | 수동 린팅 | 파일 린팅 실행 |

---

## 🔌 플러그인별 사용법

### 🎯 LSP (Language Server Protocol)
#### 지원 언어
- **Python**: basedpyright (타입 체킹)
- **JavaScript/TypeScript**: eslint
- **Svelte**: svelte-language-server
- **Lua**: lua-language-server
- **HTML/CSS**: html-lsp, css-lsp
- **JSON**: json-lsp

#### 가상환경 자동 감지
1. `.venv` (프로젝트 루트)
2. Poetry 환경
3. Conda 환경
4. 시스템 Python

### 🔍 Telescope (파일/텍스트 검색)
#### 주요 기능
- **파일 검색**: 파일명으로 검색
- **전체 텍스트 검색**: 프로젝트 전체에서 문자열 검색
- **LSP 통합**: 정의, 참조, 심볼 검색
- **Git 통합**: Git 파일 상태별 검색

#### 사용 팁
- 검색 중 `<C-q>`로 결과를 quickfix로 전송
- `<C-j/k>`로 결과 이동

### 🔧 Mason (도구 관리)
#### 자동 설치되는 도구들
- **LSP 서버**: basedpyright, svelte-language-server
- **포맷터**: prettier, stylua, ruff
- **린터**: eslint_d, ruff

#### 사용법
```vim
:Mason  " Mason UI 열기
:MasonUpdate  " 도구 업데이트
:MasonInstall <도구명>  " 특정 도구 설치
```

### 🎨 Conform (코드 포맷팅)
#### 언어별 포맷터
- **Python**: ruff (format + organize imports)
- **JavaScript/TypeScript**: prettier
- **Svelte**: prettier
- **CSS/HTML/JSON**: prettier
- **Lua**: stylua

#### 자동 포맷팅
- 파일 저장 시 자동 포맷팅
- 1000ms 타임아웃 설정

### 🔍 Trouble (진단 관리)
#### 주요 기능
- **진단 통합**: 모든 LSP 진단을 한 곳에서 관리
- **심볼 브라우저**: 문서 구조 탐색
- **Quickfix 개선**: 더 나은 UI로 문제 목록 표시

### 🐛 nvim-dap (디버깅)
#### Python 디버깅 설정
- **환경 자동 감지**: .venv, poetry, conda 지원
- **브레이크포인트**: 조건부 브레이크포인트 지원
- **UI 통합**: 자동 UI 열기/닫기
- **가상 텍스트**: 변수 값 인라인 표시

#### 디버깅 워크플로우
1. `<leader>b`로 브레이크포인트 설정
2. `<F5>`로 디버깅 시작
3. `<F10/11/12>`로 스텝 실행
4. `<leader>de`로 변수 값 확인

### 🧪 Neotest (테스트 실행)
#### 지원 테스트 프레임워크
- **Python**: pytest, unittest
- **실시간 결과**: 파일 내에서 테스트 결과 표시
- **디버그 통합**: nvim-dap와 연동

#### 테스트 워크플로우
1. `<leader>tt`로 커서 위치 테스트 실행
2. `<leader>ts`로 테스트 결과 요약 보기
3. 실패한 테스트는 `]t`로 빠르게 이동

---

## 🐍 Python 개발 워크플로우

### 1. 프로젝트 설정
```bash
# 프로젝트 생성
mkdir my-project
cd my-project

# 가상환경 생성 (.venv 권장)
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# .venv\Scripts\activate   # Windows

# 의존성 설치
pip install numpy pandas torch
pip install pytest  # 테스트용
pip install ruff     # 린팅/포맷팅용
```

### 2. Neovim에서 프로젝트 열기
```bash
nvim .  # 현재 디렉토리에서 열기
```

### 3. 개발 워크플로우
1. **파일 탐색**: `<leader>ff`로 파일 찾기
2. **코드 작성**: LSP 자동완성과 타입 체킹
3. **포맷팅**: 저장 시 자동 ruff 포맷팅
4. **테스트**: `<leader>tt`로 테스트 실행
5. **디버깅**: `<F5>`로 디버그 세션 시작
6. **Git**: `<leader>hs`로 변경사항 커밋

### 4. 에러 해결
- **Import 에러**: `:LspRestart`로 LSP 재시작
- **환경 인식 실패**: 프로젝트 루트에 `.venv` 폴더 확인
- **타입 체킹**: `<leader>xx`로 전체 진단 확인

---

## 🎨 Svelte 개발 워크플로우

### 1. SvelteKit 프로젝트 설정
```bash
npm create svelte@latest my-app
cd my-app
npm install
npm install -D prettier eslint
```

### 2. Neovim에서 개발
1. **컴포넌트 작성**: `.svelte` 파일에서 LSP 지원
2. **자동완성**: HTML, CSS, JS 통합 자동완성
3. **포맷팅**: 저장 시 prettier 자동 포맷팅
4. **타입스크립트**: `.ts` 파일 완전 지원

### 3. 주요 기능
- **Emmet 지원**: Svelte 컴포넌트에서 HTML 약어 확장
- **CSS 자동완성**: 스타일 블록에서 CSS 자동완성
- **스크립트 지원**: TypeScript/JavaScript 완전 지원

---

## 🔧 문제 해결

### LSP 관련 문제
```vim
:LspInfo          " LSP 상태 확인
:LspRestart       " LSP 재시작
:checkhealth lsp  " LSP 건강 상태 체크
```

### Mason 관련 문제
```vim
:Mason            " Mason UI에서 도구 상태 확인
:MasonUpdate      " 모든 도구 업데이트
:MasonLog         " Mason 로그 확인
```

### 플러그인 관련 문제
```vim
:Lazy             " Lazy UI에서 플러그인 상태 확인
:Lazy update      " 모든 플러그인 업데이트
:Lazy clean       " 사용하지 않는 플러그인 정리
:Lazy health      " 플러그인 건강 상태 체크
```

### Python 환경 문제
1. **가상환경 확인**:
   ```bash
   # 프로젝트 루트에서
   ls -la .venv/  # .venv 폴더 존재 확인
   ```

2. **Python 경로 확인**:
   ```vim
   :lua for _, client in pairs(vim.lsp.get_clients()) do if client.name == 'basedpyright' then print(vim.inspect(client.config.settings.python)) end end
   ```

3. **pyrightconfig.json 생성**:
   ```json
   {
     "venvPath": ".",
     "venv": ".venv",
     "exclude": ["**/node_modules", "**/__pycache__"],
     "reportMissingImports": true,
     "pythonVersion": "3.11"
   }
   ```

### 성능 최적화
- **지연 로딩**: 대부분 플러그인이 필요할 때만 로딩됨
- **LSP 제한**: 파일당 40,000줄 제한
- **진단 제한**: 열린 파일만 진단 (`openFilesOnly`)

---

## 📚 추가 리소스

### 유용한 명령어
```vim
:h <키워드>       " 도움말 검색
:messages        " 메시지 로그 확인
:checkhealth     " 전체 건강 상태 체크
:Telescope       " Telescope 명령어 목록
```

### 설정 파일 위치
```
~/.config/nvim/
├── init.lua                    # 메인 설정 파일
├── lua/
│   ├── vim-options.lua         # 기본 Vim 옵션
│   └── plugins/               # 플러그인 설정들
│       ├── lsp-config.lua     # LSP 설정
│       ├── telescope.lua      # 검색 설정
│       ├── dap.lua           # 디버깅 설정
│       └── ...               # 기타 플러그인들
└── lazy-lock.json             # 플러그인 버전 락
```

### 커스터마이징 팁
1. **개인 설정 추가**: `lua/vim-options.lua` 수정
2. **키맵 변경**: 각 플러그인 파일에서 키맵 섹션 수정
3. **테마 변경**: `lua/plugins/catppuccin.lua` 수정
4. **새 플러그인 추가**: `lua/plugins/` 폴더에 새 파일 생성

---

**🎉 Happy Coding with Neovim! 🎉**

> 이 설정은 Python과 Svelte 개발에 최적화되어 있습니다. 
> 문제가 있거나 개선사항이 있다면 설정 파일을 직접 수정하거나 
> GitHub Issues를 통해 피드백을 남겨주세요.