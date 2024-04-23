import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const session = new Supabase.ai.Session("gte-small");
const tableName = "description_embeddings";

serve(async (req) => {
  const data = await req.json();
  console.log("Received request: ", data);

  const authHeader = req.headers.get("Authorization")!;
  const supabaseClient = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_ANON_KEY") ?? "",
    { global: { headers: { Authorization: authHeader } } }
  );

  const {
    record: { id, description },
  } = data;

  const embeddings = await session.run(description, {
    mean_pool: true,
    normalize: true,
  });

  const payload = {
    id,
    embeddings,
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
