package recipe

import (
	"context"
	"log"
	"strconv"

	"github.com/asdine/storm/v3"
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

// var defaultRecipe *proto.Recipe
var pathDB string

const currentKey = "current"
const keyValueName = "recipe"

type Recipe struct {
	UUID      string `storm:"id"`
	Name      string
	Info      string
	Selectors map[string]*proto.Selector
	Sliders   map[string]*proto.Setting
}

// Init opens the badgerDB
func Init(ctx context.Context, path string) error {
	pathDB = path
	log.Printf("Initiating recipes store at %s", pathDB)
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	// err = db.Init(&Recipe{})
	// if err != nil {
	// 	return err
	// }
	db.Close()
	return err
}

func ToRecipe(r *proto.Recipe) *Recipe {
	sliderMap := make(map[string]*proto.Setting)
	for _, v := range r.Settings {
		sliderMap[v.Name] = v
	}
	selectorMap := make(map[string]*proto.Selector)
	for _, v := range r.Selectors {
		selectorMap[v.Name] = v
	}
	return &Recipe{
		UUID:      r.Uuid,
		Name:      r.Title,
		Info:      r.Info,
		Selectors: selectorMap,
		Sliders:   sliderMap,
	}
}

func ToProto(r *Recipe) *proto.Recipe {
	sliders := []*proto.Setting{}
	for _, v := range r.Sliders {
		sliders = append(sliders, v)
	}
	selectors := []*proto.Selector{}
	for _, v := range r.Selectors {
		selectors = append(selectors, v)
	}
	return &proto.Recipe{
		Uuid:      r.UUID,
		Title:     r.Name,
		Info:      r.Info,
		Settings:  sliders,
		Selectors: selectors,
	}
}

func ReadCurrentRecipeUUID() (string, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return "", err
	}
	defer db.Close()
	var uuid string
	err = db.Get(keyValueName, currentKey, &uuid)
	if err != nil {
		return "", err
	}
	return uuid, nil
}

func ReadCurrentRecipe() (*Recipe, error) {
	uuid, err := ReadCurrentRecipeUUID()
	if err != nil {
		return nil, err
	}
	return ReadRecipe(uuid)
}

func UpdateCurrentRecipe(uuid string) error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Set(keyValueName, currentKey, uuid)
	if err != nil {
		return err
	}
	return err
}

func ReadRecipe(uuid string) (*Recipe, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return nil, err
	}
	defer db.Close()
	// Get the recipe struct
	recipe := &Recipe{}
	err = db.One("UUID", uuid, recipe)
	if err != nil {
		return nil, err
	}
	return recipe, nil
}

func UpdateRecipe(r *Recipe) error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Update(r)
	return err
}

func ReadAllRecipes() ([]Recipe, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return nil, err
	}
	defer db.Close()
	var recipes []Recipe
	err = db.All(&recipes)
	return recipes, err
}

func SaveRecipe(r *Recipe) error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Save(r)
	return err
}

func recipeToString(r *proto.Recipe) []string {
	var settings []string
	for _, s := range r.Settings {
		str := "p#"
		str += s.GetName()
		str += "#"
		str += strconv.FormatFloat(s.GetValue(), 'f', 10, 64)
		settings = append(settings, str)
	}
	return settings
}
