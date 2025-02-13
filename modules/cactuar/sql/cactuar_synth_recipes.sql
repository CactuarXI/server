-- ---------------------------------------------------------------------------
--  Notes: Cactuar Synth Recipes
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- Add custom recipes to synth_recipes
-- ------------------------------------------------------------

LOCK TABLE `synth_recipes` WRITE;

--  Template
-- INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, 'Content_Tag') VALUES ();
-- Crystals 
-- Fire(4096,4238) Ice(4097,4239) Wind(4098,4240) Earth(4099,4241) Lightning(4100,4242) Water(4101,4243) Light(4102,4244) Dark(4103,4245)     

INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, `content_tag`)
VALUES (2, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4099, 4241, 17545, 17547, 17549, 17551, 17553, 17555, 17557, 17559, 18632, 18632, 18632, 18632, 1, 1, 1, 1, 'Iridal Staff', NULL);

INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, `content_tag`)
VALUES (2, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4099, 4241, 17546, 17548, 17550, 17552, 17554, 17556, 17558, 17560, 18633, 18633, 18633, 18633, 1, 1, 1, 1, 'Chatoyant Staff', NULL);

INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, `content_tag`)
VALUES (2, 0, 0, 100, 0, 0, 0, 0, 0, 0, 4099, 4241, 15495, 15496, 15497, 15498, 15499, 15500, 15501, 15502, 27510, 27510, 27510, 27510, 1, 1, 1, 1, 'Fotia Gorget', NULL);

INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, `content_tag`)
VALUES (2, 0, 0, 0, 0, 100, 0, 0, 0, 0, 4099, 4241, 15435, 15436, 15437, 15438, 15439, 15440, 15441, 15442, 28419, 28419, 28419, 28419, 1, 1, 1, 1, 'Hachirin-no-Obi', NULL);

INSERT INTO `synth_recipes` (`Desynth`, `KeyItem`, `Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`, `Crystal`, `HQCrystal`, `Ingredient1`, `Ingredient2`, `Ingredient3`, `Ingredient4`, `Ingredient5`, `Ingredient6`, `Ingredient7`, `Ingredient8`, `Result`, `ResultHQ1`, `ResultHQ2`, `ResultHQ3`, `ResultQty`, `ResultHQ1Qty`, `ResultHQ2Qty`, `ResultHQ3Qty`, `ResultName`, `content_tag`)
VALUES (0, 0, 0, 88, 40, 0, 0, 0, 0, 0, 4098, 4240, 657, 664, 745, 914, 0, 0, 0, 0, 18712, 18712, 18712, 18712, 33, 66, 99, 99, 'Koga Shuriken', NULL);


UNLOCK TABLES;
