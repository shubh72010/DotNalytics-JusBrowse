#!/bin/bash
set -e

# Validate required environment variables
if [ -z "$SUPABASE_URL" ]; then
  echo "❌ Error: SUPABASE_URL not set"
  exit 1
fi

if [ -z "$SUPABASE_ANON_KEY" ]; then
  echo "❌ Error: SUPABASE_ANON_KEY not set"
  exit 1
fi

TABLE_NAME="${TABLE_NAME:-usage_stats}"

echo "🔨 Building JusBrowse Analytics Dashboard..."
echo "📍 Supabase: ${SUPABASE_URL}"
echo "📊 Table: ${TABLE_NAME}"

# Replace placeholders in index.html
# Extract just the domain from SUPABASE_URL (remove https://)
SUPABASE_DOMAIN="${SUPABASE_URL#https://}"

# Create backup just in case
cp index.html index.html.bak

# Use sed to replace all three placeholders
sed -i "s|https://YOUR_PROJECT_ID\.supabase\.co|${SUPABASE_URL}|g" index.html
sed -i "s|YOUR_ANON_KEY|${SUPABASE_ANON_KEY}|g" index.html
sed -i "s|\"usage_stats\"|\"${TABLE_NAME}\"|g" index.html

echo "✅ Build complete!"
echo "🚀 Dashboard ready at: https://dotnalytics-jusbrowse.onrender.com"
