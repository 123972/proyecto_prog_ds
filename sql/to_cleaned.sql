create schema if not exists cleaned;

drop table if exists cleaned.Artists;

create table cleaned.Artists as (
  select
      "ConstituentID"::int as artist,
      "DisplayName" as name,
      "Nationality" as nationality,
      "Gender" as gender,
      "BeginDate"::int as birth_year,
      "EndDate"::int as death_year,
      "Wiki QID" as wiki_qid,
      "ULAN"::int as ulan
    from raw.Artists
  );

create index cleaned_artists_artist_ix on cleaned.Artists(artist);

drop table if exists cleaned.Artworks;

create table cleaned.Artworks as (
  select
    a."Title" as title,
    s.artist::int,
    substring(a."Date", '([0-9]{4})')::int as artwork_year,
    a."Medium" as medium,
    a."CreditLine" as creditline,
    a."AccessionNumber" as accession,
    a."Classification" as classification,
    a."Department" as department,
    to_date(a."DateAcquired",'YYYY-MM-DD') as date_acquired,
    a."Cataloged"::boolean as cataloged,
    a."ObjectID"::int as artwork,
    a."URL" as url,
    a."ThumbnailURL" as thumbnailurl,
    a."Circumference (cm)"::float as circumference_cm,
    a."Depth (cm)"::float as depth_cm,
    a."Diameter (cm)"::float as diameter_cm,
    a."Height (cm)"::float as height_cm,
    a."Length (cm)"::float as lenght_cm,
    a."Weight (kg)"::float as weight_cm,
    a."Width (cm)"::float as width_cm,
    a."Seat Height (cm)"::float as seat_height_cm,
    a."Duration (sec)"::float as duration_sec
    from raw.Artworks a, unnest(string_to_array(a."ConstituentID", ',')) s(artist)
  );

create index cleaned_artworks_artwork_ix on cleaned.Artworks(artwork);
