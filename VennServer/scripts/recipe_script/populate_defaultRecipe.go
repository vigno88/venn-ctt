package main

import (
	"context"
	"log"

	config "github.com/vigno88/Venn/VennServer/configs"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func main() {
	c := config.GetDefaultConfig()
	// Add the default recipe to the recipe store
	uuid := util.GetNewUUID(context.Background())
	c.Recipe.UUID = uuid
	err := recipe.Init(context.Background(), util.PathRecipe)
	if err != nil {
		log.Fatalf("Error while init : %s\n", err.Error())
	}
	err = recipe.SaveRecipe(&c.Recipe)
	if err != nil {
		log.Fatalf("Error while saving : %s\n", err.Error())
	}
	err = recipe.UpdateCurrentRecipe(uuid)
	if err != nil {
		log.Fatalf("Error while updating : %s\n", err.Error())
	}
	log.Println("Default recipe setup done")
}
