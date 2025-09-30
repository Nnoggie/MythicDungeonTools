local MDT = MDT

-- A Schema describes the structure of a table. In it you can define how
-- tables should be exported to Lua. This makes it possible to
-- export a table to Lua while keeping the structure of the table consistent
-- even if the table is consisting of unindexed tables.

local schemas = {
  ["pois"] = {
    name = "MDT.mapPOIs[dungeonIndex]",
    type = "array",
    fields = {
      type = "array",
      fields = {
        type = "schemaArray",
        fields = {
          {
            name = "template",
            type = "string"
          },
          {
            name = "type",
            type = "string"
          },
          {
            name = "x",
            type = "number"
          },
          {
            name = "y",
            type = "number"
          },
          {
            name = "difficulty",
            type = "number"
          },
          {
            name = "scale",
            type = "number"
          },
          {
            name = "target",
            type = "number"
          },
          {
            name = "direction",
            type = "number"
          },
          {
            name = "connectionIndex",
            type = "number"
          },
          {
            name = "text",
            type = "string"
          },
          {
            name = "graveyardDescription",
            type = "string"
          },
          {
            name = "index",
            type = "number"
          },
          {
            name = "npcId",
            type = "number"
          },
          {
            name = "season",
            type = "number"
          },
          {
            name = "botType",
            type = "number"
          },
          {
            name = "botTypeIndex",
            type = "number"
          },
          {
            name = "cageIndex",
            type = "number"
          },
          {
            name = "itemType",
            type = "number"
          },
          {
            name = "itemIndex",
            type = "number"
          },
          {
            name = "chainIndex",
            type = "number"
          },
          {
            name = "textAnchor",
            type = "string"
          },
          {
            name = "textAnchorTo",
            type = "string"
          },
          {
            name = "tooltipText",
            type = "string"
          },
          {
            name = "doorName",
            type = "string"
          },
          {
            name = "lockpick",
            type = "boolean"
          },
          {
            name = "doorDescription",
            type = "string"
          },
          {
            name = "starIndex",
            type = "number"
          },
          {
            name = "formattedDoorDescription",
            type = "array",
            fields = {
              type = "string"
            }
          },
          {
            name = "formattedText",
            type = "array",
            fields = {
              type = "string"
            }
          },
          {
            name = "value1",
            type = "number"
          },
          {
            name = "value2",
            type = "number"
          },
          {
            name = "value3",
            type = "number"
          },
        }
      }
    },
  },
  ["enemies"] = {
    name = "MDT.dungeonEnemies[dungeonIndex]",
    type = "array",
    fields = {
      type = "schemaArray",
      fields = {
        {
          name = "name",
          type = "string"
        },
        {
          name = "id",
          type = "number"
        },
        {
          name = "count",
          type = "number"
        },
        {
          name = "health",
          type = "number"
        },
        {
          name = "ignoreFortified",
          type = "boolean"
        },
        {
          name = "scale",
          type = "number"
        },
        {
          name = "neutral",
          type = "boolean"
        },
        {
          name = "stealth",
          type = "boolean"
        },
        {
          name = "stealthDetect",
          type = "boolean"
        },
        {
          name = "displayId",
          type = "number"
        },
        {
          name = "iconTexture",
          type = "number"
        },
        {
          name = "creatureType",
          type = "string"
        },
        {
          name = "level",
          type = "number"
        },
        {
          name = "isBoss",
          type = "boolean"
        },
        {
          name = "encounterID",
          type = "number"
        },
        {
          name = "instanceID",
          type = "number"
        },
        {
          name = "powers",
          type = "array",
          fields = {
            type = "schemaArray",
            fields = {
              {
                name = "dps",
                type = "boolean"
              },
              {
                name = "healer",
                type = "boolean"
              },
              {
                name = "tank",
                type = "boolean"
              },
            },
          }
        },
        {
          name = "characteristics",
          type = "schemaArray",
          fields = {
            {
              name = "Taunt",
              type = "boolean",
            },
            {
              name = "Incapacitate",
              type = "boolean",
            },
            {
              name = "Subjugate Demon",
              type = "boolean",
            },
            {
              name = "Control Undead",
              type = "boolean",
            },
            {
              name = "Silence",
              type = "boolean",
            },
            {
              name = "Knock",
              type = "boolean",
            },
            {
              name = "Grip",
              type = "boolean",
            },
            {
              name = "Mind Control",
              type = "boolean",
            },
            {
              name = "Shackle Undead",
              type = "boolean",
            },
            {
              name = "Polymorph",
              type = "boolean",
            },
            {
              name = "Root",
              type = "boolean",
            },
            {
              name = "Fear",
              type = "boolean",
            },
            {
              name = "Banish",
              type = "boolean",
            },
            {
              name = "Disorient",
              type = "boolean",
            },
            {
              name = "Repentance",
              type = "boolean",
            },
            {
              name = "Imprison",
              type = "boolean",
            },
            {
              name = "Sap",
              type = "boolean",
            },
            {
              name = "Stun",
              type = "boolean",
            },
            {
              name = "Slow",
              type = "boolean",
            },
            {
              name = "Sleep Walk",
              type = "boolean",
            },
            {
              name = "Scare Beast",
              type = "boolean",
            },
            {
              name = "Hibernate",
              type = "boolean",
            },
            {
              name = "Turn Evil",
              type = "boolean",
            },
            {
              name = "Mind Soothe",
              type = "boolean",
            },
          }
        },
        {
          name = "spells",
          type = "array",
          fields = {
            type = "schemaArray",
            fields = {
              {
                name = "interruptible",
                type = "boolean"
              },
              {
                name = "magic",
                type = "boolean"
              },
              {
                name = "poison",
                type = "boolean"
              },
              {
                name = "disease",
                type = "boolean"
              },
              {
                name = "curse",
                type = "boolean"
              },
              {
                name = "bleed",
                type = "boolean"
              },
              {
                name = "enrage",
                type = "boolean"
              },
            },
          }
        },
        {
          name = "clones",
          type = "array",
          fields = {
            type = "schemaArray",
            fields = {
              {
                name = "x",
                type = "number"
              },
              {
                name = "y",
                type = "number"
              },
              {
                name = "g",
                type = "number"
              },
              {
                name = "sublevel",
                type = "number"
              },
              {
                name = "scale",
                type = "number"
              },
              {
                name = "note",
                type = "string"
              },
              {
                name = "patrol",
                type = "array",
                fields = {
                  type = "schemaArray",
                  fields = {
                    {
                      name = "x",
                      type = "number"
                    },
                    {
                      name = "y",
                      type = "number"
                    },
                  },
                },
              },
              {
                name = "constrained",
                type = "schemaArray",
                fields = {
                  {
                    name = "index",
                    type = "number",
                  },
                  {
                    name = "amount",
                    type = "number",
                  },
                },
              },
            },
          },
        },
      },
    }
  }
}

--- @param schemaName "enemies" | "pois"
function MDT:GetSchema(schemaName)
  return schemas[schemaName]
end
