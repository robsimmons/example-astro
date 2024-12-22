export const prerender = false;
export async function GET({}) {
  return new Response(
    JSON.stringify({ value: Math.floor(Math.random() * 10000) })
  );
}
