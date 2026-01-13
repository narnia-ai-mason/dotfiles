# Context7 API Reference

Context7 provides LLM-optimized documentation retrieval for libraries and frameworks.

## Authentication

```bash
Authorization: Bearer $CONTEXT7_API_KEY
```

Get your API key at [context7.com/dashboard](https://context7.com/dashboard)

## Endpoints

### 1. Search Libraries

Find libraries by name with intelligent ranking.

**Endpoint:** `GET https://context7.com/api/v2/libs/search`

**Parameters:**
| Parameter | Required | Description |
|-----------|----------|-------------|
| `libraryName` | Yes | Library name (e.g., "react", "nextjs", "express") |
| `query` | No | User's question for relevance ranking |

**Example:**
```bash
curl -s "https://context7.com/api/v2/libs/search?libraryName=next.js&query=setup+ssr" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

**Response:**
```json
{
  "results": [
    {
      "id": "/vercel/next.js",
      "title": "Next.js",
      "description": "Next.js enables you to create full-stack web...",
      "branch": "canary",
      "totalTokens": 824953,
      "totalSnippets": 3336,
      "stars": 131745,
      "trustScore": 10,
      "versions": ["v14.3.0-canary.87", "v13.5.11", "v15.1.8"]
    }
  ]
}
```

**Key fields:**
- `id`: Use this as `libraryId` in the context endpoint
- `versions`: Available version tags (append to id like `/vercel/next.js/v15.1.8`)
- `trustScore`: 1-10, higher is more reliable
- `totalTokens`: Total documentation size

---

### 2. Get Documentation Context

Retrieve relevant documentation snippets for a query.

**Endpoint:** `GET https://context7.com/api/v2/context`

**Parameters:**
| Parameter | Required | Description |
|-----------|----------|-------------|
| `libraryId` | Yes | Library ID from search (e.g., `/vercel/next.js`) |
| `query` | Yes | User's question or task |
| `tokens` | No | Max tokens to return (default varies) |

**Example:**
```bash
curl -s "https://context7.com/api/v2/context?libraryId=/vercel/next.js&query=How+to+implement+authentication+with+middleware" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

**Response:**
```json
{
  "codeSnippets": [
    {
      "codeTitle": "Middleware Authentication Example",
      "codeDescription": "Shows how to check auth in middleware...",
      "codeLanguage": "typescript",
      "codeTokens": 130,
      "codeId": "middleware.mdx#_snippet_3",
      "pageTitle": "Middleware",
      "codeList": [
        {
          "language": "typescript",
          "code": "import { NextResponse } from 'next/server'\nimport type { NextRequest } from 'next/server'\n\nexport function middleware(request: NextRequest) {\n  // Auth logic here\n}"
        }
      ]
    }
  ],
  "infoSnippets": [
    {
      "pageId": "middleware.mdx",
      "breadcrumb": "Routing > Middleware",
      "content": "Middleware allows you to run code before a request is completed...",
      "contentTokens": 85
    }
  ]
}
```

**Response structure:**
- `codeSnippets`: Code examples with language, tokens, and source
- `infoSnippets`: Explanatory text from documentation
- Both are ranked by relevance to your query

---

## Usage Patterns

### Pattern 1: Known Library Lookup
```bash
# Direct lookup when you know the library
LIBRARY_ID="/vercel/next.js"
curl -s "https://context7.com/api/v2/context?libraryId=$LIBRARY_ID&query=app+router+layouts" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

### Pattern 2: Search Then Fetch
```bash
# 1. Search for library
SEARCH=$(curl -s "https://context7.com/api/v2/libs/search?libraryName=fastapi" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY")

# 2. Extract library ID
LIBRARY_ID=$(echo $SEARCH | jq -r '.results[0].id')

# 3. Get context
curl -s "https://context7.com/api/v2/context?libraryId=$LIBRARY_ID&query=dependency+injection" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

### Pattern 3: Specific Version
```bash
# Append version to library ID
curl -s "https://context7.com/api/v2/context?libraryId=/vercel/next.js/v14.0.0&query=pages+router" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

---

## Common Library IDs

Popular libraries for quick reference:

| Library | ID |
|---------|-----|
| Next.js | `/vercel/next.js` |
| React | `/facebook/react` |
| Vue | `/vuejs/vue` |
| Express | `/expressjs/express` |
| FastAPI | `/tiangolo/fastapi` |
| Django | `/django/django` |
| Tailwind CSS | `/tailwindlabs/tailwindcss` |
| Prisma | `/prisma/prisma` |

For other libraries, always use the search endpoint first.

---

## Error Handling

| Status | Meaning | Action |
|--------|---------|--------|
| 200 | Success | Parse response |
| 401 | Invalid API key | Check CONTEXT7_API_KEY |
| 404 | Library not found | Try search endpoint or use Exa |
| 429 | Rate limited | Wait and retry |
| 500 | Server error | Retry or fallback to Exa |

---

## Tips

1. **Be specific in queries** - "Next.js middleware authentication JWT" beats "auth"
2. **Check token counts** - Large responses may need summarization
3. **Use versions** - Pin to specific version for accuracy when needed
4. **Fallback ready** - If results are empty or low quality, switch to Exa
