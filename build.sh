#!/bin/bash
# build.sh - Inject environment variables into index.html before deployment

# Required environment variables
SUPABASE_URL="${SUPABASE_URL:?Error: SUPABASE_URL not set}"
SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY:?Error: SUPABASE_ANON_KEY not set}"
TABLE_NAME="${TABLE_NAME:=usage_stats}"

echo "🔨 Building JusBrowse Analytics..."
echo "📍 Supabase URL: $SUPABASE_URL"
echo "📊 Table: $TABLE_NAME"

# Replace placeholders in index.html
sed -i.bak \
  -e "s|YOUR_PROJECT_ID\.supabase\.co|${SUPABASE_URL#https://}|g" \
  -e "s|YOUR_ANON_KEY|$SUPABASE_ANON_KEY|g" \
  -e "s|usage_stats|$TABLE_NAME|g" \
  index.html

echo "✅ Build complete! index.html ready for deployment."
