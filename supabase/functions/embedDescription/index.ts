import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import {
  env,
  pipeline,
} from "https://cdn.jsdelivr.net/npm/@xenova/transformers@2.5.0";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

env.useBrowserCache = false;
env.allowLocalModels = false;

const supabaseClient = createClient(
  Deno.env.get("SUPABASE_URL") ?? "",
  Deno.env.get("SUPABASE_ANON_KEY") ?? ""
);

const pipe = await pipeline("feature-extraction", "Supabase/gte-small");

serve(async (req) => {
  const data = await req.json();
  const tableName = "description_embeddings";
  console.log("Received request: ", data);

  const {
    record: { id, description },
  } = data;

  const output = await pipe(description, {
    pooling: "mean",
    normalize: true,
  });
  const description_embeddings = Array.from(output.data);

  const payload = {
    id,
    description_embeddings,
  };

  const res = await supabaseClient.from(tableName).insert(payload);
  const error = res?.error;

  if (error) {
    console.error(error);
    return error;
  }

  console.log("Embeddings saved");
  return new Response(JSON.stringify({ payload }), {
    headers: { "Content-Type": "application/json" },
  });
});
