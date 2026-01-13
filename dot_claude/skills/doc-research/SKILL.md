---
name: doc-research
description: Research technical documentation for libraries, frameworks, and APIs. Use this skill when investigating how to use a technology, finding code examples, or reading specific documentation URLs. Triggers on queries like "how do I use X", "find docs for Y", "read this documentation URL", or when coding tasks require understanding unfamiliar libraries.
---

# Documentation Research Skill

Efficiently research technical documentation using a layered approach to minimize token usage.

## Decision Flow

```
User query about technology/library
           │
           ▼
┌─────────────────────────┐
│  1. Context7 (Primary)  │ ──── Known library/framework docs
└───────────┬─────────────┘
            │ Not found or insufficient
            ▼
┌─────────────────────────┐
│    2. Exa (Secondary)   │ ──── Web search for tutorials, blogs, recent content
└───────────┬─────────────┘
            │ User provides specific URL
            ▼
┌─────────────────────────┐
│ 3. ref_read_url (MCP)   │ ──── Read and convert URL to clean markdown
└─────────────────────────┘
```

## 1. Context7 (Primary)

Use for well-known libraries and frameworks. Token-efficient, curated documentation.

**When to use:**
- Looking up library/framework APIs (React, Next.js, Express, etc.)
- Finding code examples for specific functions
- Understanding configuration options

**API Reference:** See [references/context7/API.md](references/context7/API.md)

**Quick example:**
```bash
# Search for library
curl -s "https://context7.com/api/v2/libs/search?libraryName=nextjs&query=server+components" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY" | jq '.results[0].id'

# Get documentation context
curl -s "https://context7.com/api/v2/context?libraryId=/vercel/next.js&query=how+to+use+server+components" \
  -H "Authorization: Bearer $CONTEXT7_API_KEY"
```

## 2. Exa (Secondary)

Use when Context7 doesn't have the library or needs supplementation.

**When to use:**
- Library not in Context7's index
- Need recent blog posts, tutorials, or discussions
- Looking for real-world usage examples beyond official docs
- Comparing different approaches or solutions

**API Reference:** See [references/exa/API.md](references/exa/API.md)

**Quick example:**
```bash
curl -s -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "how to implement authentication in FastAPI 2024", "numResults": 5}'
```

## 3. Ref.tools MCP (URL Reader)

Use **ref_read_url** MCP tool when user provides a specific documentation URL.

**When to use:**
- User says "read this URL: ..."
- Need to fetch content from a specific documentation page
- URL found via Exa needs detailed reading

**Usage:**
Call the `ref_read_url` MCP tool with the URL parameter. This tool converts web pages to clean, readable markdown optimized for LLM consumption.

```
Tool: ref_read_url
Parameter: url = "https://docs.example.com/guide"
```

## Strategy Guidelines

1. **Start with Context7** for any recognized library name
2. **Check Context7 results quality** - if snippets seem incomplete or outdated, supplement with Exa
3. **Use Exa for discovery** when exploring unfamiliar territory or needing diverse sources
4. **Use ref_read_url** only for specific URLs - don't use it for general searching
5. **Combine sources** when building comprehensive understanding

## Environment Variables Required

```
CONTEXT7_API_KEY  - Get from context7.com/dashboard
EXA_API_KEY       - Get from exa.ai
```

Note: ref_read_url requires Ref.tools MCP server to be configured separately.
