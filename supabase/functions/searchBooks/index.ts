import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const SEARCH_LIMIT = 10;
const BOOK_TABLE = "books";
const BOOKS_API = "https://openlibrary.org/works/";

const session = new Supabase.ai.Session("gte-small");

serve(async (req) => {
  const authHeader = req.headers.get("Authorization")!;
  const data = await req.json();
  console.log("Received request: ", data);

  const supabaseClient = createClient(
    Deno.env.get("SUPABASE_URL") ?? "",
    Deno.env.get("SUPABASE_ANON_KEY") ?? "",
    { global: { headers: { Authorization: authHeader } } }
  );

  const { searchQuery } = data;
  const query_embedding = await session.run(searchQuery, {
    mean_pool: true,
    normalize: true,
  });
  console.log("Query embedding generated");

  const promises: Promise<any>[] = [];
  promises.push(
    supabaseClient.rpc("match_books", {
      query_embedding,
      match_threshold: 0.8,
      match_count: SEARCH_LIMIT,
    })
  );

  promises.push(
    await supabaseClient
      .from(BOOK_TABLE)
      .select()
      .textSearch("title_description", `${searchQuery}`)
  );

  const [contextualMatches, fullTextSearchMatches] = await Promise.all(
    promises
  );

  if (contextualMatches.error || fullTextSearchMatches.error) {
    console.error(contextualMatches.error || fullTextSearchMatches.error);
    return contextualMatches.error || fullTextSearchMatches.error;
  }

  const matches = [
    ...contextualMatches.data,
    ...fullTextSearchMatches.data,
  ].reduce((acc: any[], current: any) => {
    if (!acc.some((item) => item.id === current.id)) {
      acc.push(current);
    }
    return acc;
  }, []);
  console.log("Matches found: ", matches);

  const booksResponse = await fetchFromOpenLibrary(
    matches.map((book: any) => book.id)
  );
  console.log("Books fetched: ", booksResponse);

  return new Response(JSON.stringify({ books: booksResponse }), {
    headers: { "Content-Type": "application/json" },
  });
});

const fetchFromOpenLibrary = async (bookIds: string[]) => {
  console.log("Fetching book data from Open Library");
  const bookDataPromises = bookIds.map((bookId: string) =>
    fetch(`${BOOKS_API}${bookId}.json`)
  );

  const bookRatingPromises = bookIds.map((bookId: string) =>
    fetch(`${BOOKS_API}${bookId}/ratings.json`)
  );

  const bookData = await Promise.all(bookDataPromises);
  const bookRatings = await Promise.all(bookRatingPromises);

  const bookDataJson = await Promise.all(
    bookData.map((response) => response.json())
  );

  const bookRatingJson = await Promise.all(
    bookRatings.map((response) => response.json())
  );

  console.log("Book data fetched from Open Library");

  return bookDataJson.map((book: any, index: number) => {
    return {
      id: book.key,
      description: book.description?.value,
      rating: bookRatingJson[index]?.average || 0,
    };
  });
};
