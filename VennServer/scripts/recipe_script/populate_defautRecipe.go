package defaultRecipe

import (
	"context"

	config "github.com/vigno88/Venn/VennServer/configs"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func main() {
	c := config.GetDefaultConfig()
	// Add the default recipe to the recipe store
	uuid := util.GetNewUUID(context.Background())
	c.Recipe.UUID = uuid
	recipe.SaveRecipe(&c.Recipe)
	recipe.UpdateCurrentRecipe(uuid)
}
