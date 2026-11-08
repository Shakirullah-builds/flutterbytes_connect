BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attendee_profile" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "role" text NOT NULL,
    "skills" json NOT NULL,
    "interests" text NOT NULL,
    "githubHandle" text,
    "personaTitle" text NOT NULL,
    "bioHook" text NOT NULL,
    "avatarSeed" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "collab_match" (
    "id" bigserial PRIMARY KEY,
    "devOneId" bigint NOT NULL,
    "devTwoId" bigint NOT NULL,
    "devOneName" text NOT NULL,
    "devTwoName" text NOT NULL,
    "projectTitle" text NOT NULL,
    "tagline" text NOT NULL,
    "devOneResponsibility" text NOT NULL,
    "devTwoResponsibility" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR flutterbytes_connect
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('flutterbytes_connect', '20261106191309112', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261106191309112', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20261015164015382', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261015164015382', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
