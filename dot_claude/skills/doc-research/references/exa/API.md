# Exa API Reference

Exa provides neural web search optimized for AI applications.

## Authentication

```bash
x-api-key: $EXA_API_KEY
```

Get your API key at [dashboard.exa.ai/api-keys](https://dashboard.exa.ai/api-keys)

## Endpoints

### 1. Search

Intelligent web search with optional content extraction.

**Endpoint:** `POST https://api.exa.ai/search`

**Basic Parameters:**
| Parameter | Required | Description |
|-----------|----------|-------------|
| `query` | Yes | Search query string |
| `numResults` | No | Number of results (default: 10, max: 100) |
| `type` | No | `auto` (default), `neural`, `fast`, or `deep` |

**Content Options:**
| Parameter | Description |
|-----------|-------------|
| `text` | Set `true` to include full page text |
| `highlights` | Set `true` for relevant snippets |
| `summary` | Set `true` for AI-generated summaries |

**Filtering Options:**
| Parameter | Description |
|-----------|-------------|
| `includeDomains` | Array of domains to search within |
| `excludeDomains` | Array of domains to exclude |
| `startPublishedDate` | ISO 8601 datetime, results after this date |
| `endPublishedDate` | ISO 8601 datetime, results before this date |
| `category` | Focus area: `news`, `research paper`, `github`, `pdf`, `tweet`, `company`, `people` |

**Example - Basic search with text:**
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "FastAPI authentication best practices 2024",
    "numResults": 5,
    "text": true
  }'
```

**Example - Filtered search:**
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Next.js server components tutorial",
    "numResults": 10,
    "text": true,
    "includeDomains": ["dev.to", "medium.com", "vercel.com"],
    "startPublishedDate": "2024-01-01T00:00:00.000Z"
  }'
```

**Example - Research papers:**
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "transformer architecture improvements",
    "numResults": 5,
    "category": "research paper",
    "summary": true
  }'
```

**Response:**
```json
{
  "requestId": "abc123",
  "results": [
    {
      "title": "FastAPI Security Best Practices",
      "url": "https://example.com/fastapi-security",
      "publishedDate": "2024-03-15T00:00:00.000Z",
      "author": "John Doe",
      "text": "Full page content here...",
      "highlights": ["OAuth2 with JWT tokens is recommended..."],
      "summary": "This article covers authentication patterns..."
    }
  ],
  "searchType": "neural"
}
```

---

### 2. Get Contents

Retrieve content from specific URLs (when you already have URLs).

**Endpoint:** `POST https://api.exa.ai/contents`

**Parameters:**
| Parameter | Required | Description |
|-----------|----------|-------------|
| `ids` | Yes | Array of URLs to fetch content from |
| `text` | No | Include full text |
| `highlights` | No | Include relevant highlights |
| `summary` | No | Include AI summary |

**Example:**
```bash
curl -s -X POST "https://api.exa.ai/contents" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "ids": ["https://docs.python.org/3/tutorial/index.html"],
    "text": true
  }'
```

---

### 3. Find Similar

Find pages similar to a given URL.

**Endpoint:** `POST https://api.exa.ai/findSimilar`

**Parameters:**
| Parameter | Required | Description |
|-----------|----------|-------------|
| `url` | Yes | Reference URL to find similar content |
| `numResults` | No | Number of results |

**Example:**
```bash
curl -s -X POST "https://api.exa.ai/findSimilar" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://react.dev/learn",
    "numResults": 5,
    "text": true
  }'
```

---

## Search Types

| Type | Description | Use Case |
|------|-------------|----------|
| `auto` | Automatically selects best method | General use (default) |
| `neural` | Embeddings-based semantic search | When meaning matters more than keywords |
| `fast` | Optimized for speed | Quick lookups |
| `deep` | Comprehensive with query expansion | Complex research queries |

---

## Categories

Use `category` parameter to focus search:

| Category | Best For |
|----------|----------|
| `news` | Recent news articles |
| `research paper` | Academic papers (arxiv, etc.) |
| `github` | Repositories and code |
| `pdf` | PDF documents |
| `tweet` | Twitter/X posts |
| `company` | Company websites and info |
| `people` | LinkedIn profiles |

---

## Usage Patterns

### Pattern 1: Documentation Search
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "prisma client typescript setup guide",
    "numResults": 5,
    "text": true,
    "includeDomains": ["prisma.io", "github.com/prisma"]
  }'
```

### Pattern 2: Recent Tutorials
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "how to deploy Next.js to Vercel step by step",
    "numResults": 10,
    "highlights": true,
    "startPublishedDate": "2024-06-01T00:00:00.000Z"
  }'
```

### Pattern 3: Code Examples from GitHub
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "react hook form zod validation example",
    "numResults": 5,
    "category": "github",
    "text": true
  }'
```

---

## Error Handling

| Status | Meaning | Action |
|--------|---------|--------|
| 200 | Success | Parse results |
| 400 | Bad request | Check parameters |
| 401 | Invalid API key | Check EXA_API_KEY |
| 429 | Rate limited | Wait and retry |
| 500 | Server error | Retry |

---

## Tips

1. **Use `text: true`** for full content when you need details
2. **Use `highlights: true`** for quick relevant snippets
3. **Use `summary: true`** for AI-generated overviews
4. **Filter by date** for recent content with `startPublishedDate`
5. **Use `includeDomains`** to focus on authoritative sources
6. **Combine with Context7** - use Exa when Context7 doesn't have the library

## Pricing Notes

- Neural search: $0.005 per 1-25 results
- Deep search: $0.015 per 1-25 results
- Content extraction: $0.001 per page (text/highlights/summary each)
