



import { openKv } from "Deno"

// Define the table names
const TABLES = {
  CLIP: "CLIP",
  OPENAI: "oPENAI",
  KEYS: "KEYS",
}

// Initialize OpenKV
const kv = await openKv()

// Function to add an entry to a table
async function addEntry(table: string, key: string, value: any) {
  await kv.set(`${table}:${key}`, value)
  console.log(`Added entry to ${table}: ${key} = ${JSON.stringify(value)}`)
}

// Function to get an entry from a table
async function getEntry(table: string, key: string) {
  const value = await kv.get(`${table}:${key}`)
  console.log(`Retrieved entry from ${table}: ${key} = ${JSON.stringify(value)}`)
  return value
}

// Function to delete an entry from a table
async function deleteEntry(table: string, key: string) {
  await kv.delete(`${table}:${key}`)
  console.log(`Deleted entry from ${table}: ${key}`)
}

// // Example usage
// await addEntry(TABLES.CLIP, "entry1", { content: "Hello, World!" })
// await addEntry(TABLES.OPENAI, "entry1", { prompt: "Translate to French", response: "Bonjour, le monde!" })
// await addEntry(TABLES.KEYS, "entry1", { key: "jj", command: ":wq" })

// await getEntry(TABLES.CLIP, "entry1")
// await getEntry(TABLES.OPENAI, "entry1")
// await getEntry(TABLES.KEYS, "entry1")

// await deleteEntry(TABLES.CLIP, "entry1")
// await deleteEntry(TABLES.OPENAI, "entry1")
// await deleteEntry(TABLES.KEYS, "entry1")