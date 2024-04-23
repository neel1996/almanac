drop trigger if exists "embed_description" on "public"."books";

alter table "public"."description_embeddings" disable row level security;

alter table "public"."description_embeddings" add constraint "public_description_embeddings_id_fkey" FOREIGN KEY (id) REFERENCES books(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."description_embeddings" validate constraint "public_description_embeddings_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.title_description(books)
 RETURNS text
 LANGUAGE sql
 IMMUTABLE
AS $function$
  select $1.title || ' ' || $1.description;
$function$
;

CREATE TRIGGER embed_description AFTER INSERT OR UPDATE ON public.books FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://ujlladxdjxlufxnabgki.supabase.co/functions/v1/embedDescription', 'POST', '{"Content-type":"application/json"}', '{}', '1000');


