create schema if not exists semantic;

drop table if exists semantic.entities;

create table semantic.entities as (
  select
      artist,
      nationality,
      gender,
      birth_year
    from cleaned.Artists
  );

create index semantic_entities_artist_ix on semantic.entities(artist);


drop table if exists semantic.event_death;

create table semantic.event_death as (
    select
      artist,
      death_year
      from cleaned.Artists
  );

create index semantic_event_death_artist_ix on semantic.event_death(artist);


drop table if exists semantic.event_create_artworks;

create table semantic.event_create_artworks as (
    select
      artist,
      artwork,
      artwork_year,
      substring(artwork_year::varchar(255), 3, 1)::int as artwork_decade,
      substring(artwork_year::varchar(255), 1, 2)::int + 1 as artwork_century,
      classification
      from cleaned.Artworks
  );

create index semantic_event_create_artworks_artist_ix on semantic.event_create_artworks(artist);
create index semantic_event_create_artworks_artwork_ix on semantic.event_create_artworks(artwork);
create index semantic_event_create_artworks_artwork_year_ix on semantic.event_create_artworks(artwork_year);
create index semantic_event_create_artworks_artwork_decade_ix on semantic.event_create_artworks(artwork_decade);
create index semantic_event_create_artworks_artwork_century_ix on semantic.event_create_artworks(artwork_century);
