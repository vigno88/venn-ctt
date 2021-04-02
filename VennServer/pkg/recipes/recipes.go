package recipe

import (
	"context"
	"log"
	"strconv"

	"github.com/asdine/storm/v3"
	"github.com/asdine/storm/v3/q"
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

// var defaultRecipe *proto.Recipe
var pathDB string

const currentKey = "current"
const keyValueName = "recipe"

// Used for the "IntendedFor" Setting slider field
const (
	GENERAL = "general"
	CHOICE  = "choice"
)

type SettingSlider struct {
	Id          int `storm:"id,increment"`
	Name        string
	IntendedFor string
	PartOf      string
	Type        string
	Value       float64
	Max         float64
	Min         float64
	Info        string
	Target      string
}

type SettingSelector struct {
	Id              int `storm:"id,increment"`
	PartOf          string
	Name            string
	SelectedChoice  string
	PossibleChoices []string
}

type Target struct {
	Id          int `storm:"id,increment"`
	PartOf      string
	SettingName string
	Uncertainty float64
}

type Choice struct {
	Id       int `storm:"id,increment"`
	Name     string
	PartOf   string
	Settings []string
}

type Recipe struct {
	UUID      string `storm:"id"`
	Name      string
	Info      string
	Selectors []string
	Sliders   []string
}

// Init opens the badgerDB
func Init(ctx context.Context, path string) error {
	pathDB = path
	log.Printf("Initiating recipes store at %s", pathDB)
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	err = InitDB(db)
	if err != nil {
		return err
	}
	db.Close()
	// // Get the default recipe and save it
	// defaultRecipe := GetDefaultRecipe(ctx)
	// defaultRecipe.Uuid = "default"
	// PutRecipe(ctx, defaultRecipe)

	// // Send the recipe settings to the microcontroller
	// for _, setting := range defaultRecipe.Settings {
	// 	serial.SendSetting(setting)
	// }
	// log.Println("Initial settings sent to arduino")
	return err
}

func InitDB(db *storm.DB) error {
	err := db.Init(&SettingSlider{})
	if err != nil {
		return err
	}
	err = db.Init(&SettingSelector{})
	if err != nil {
		return err
	}
	err = db.Init(&Target{})
	if err != nil {
		return err
	}
	err = db.Init(&Choice{})
	if err != nil {
		return err
	}
	err = db.Init(&Recipe{})
	if err != nil {
		return err
	}
	return nil
}

func ReadCurrentRecipe() (string, error) {
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

func ReadRecipe(uuid string) (*proto.Recipe, error) {
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
	selectors, err := getProtoSelectorsFromDB(db, recipe)
	if err != nil {
		return nil, err
	}
	sliders, err := getProtoSlidersFromDB(db, recipe)
	if err != nil {
		return nil, err
	}
	return &proto.Recipe{Uuid: uuid, Title: recipe.Name, Info: recipe.Name, Settings: sliders, Selectors: selectors}, nil
}

func getProtoSelectorsFromDB(db *storm.DB, recipe *Recipe) ([]*proto.Selector, error) {
	// Retrieve settingSelectors from backend
	var selectors []*proto.Selector
	for _, s := range recipe.Selectors {
		query := db.Select(q.Eq("Name", s), q.Eq("PartOf", recipe.UUID))
		var s SettingSelector
		query.First(&s)
		// Query the choices of the selector

	}
}

func getProtoSlidersFromDB(db *storm.DB, recipe *Recipe) ([]*proto.Setting, error) {

}

// GetCurrentRecipe get the recipe currently used by the microcontroller
// func GetCurrentRecipe(ctx context.Context) (*proto.Recipe, error) {
// 	recipe := &proto.Recipe{}
// 	db, err := bolt.Open(pathDB, 0600, nil)
// 	if err != nil {
// 		return recipe, err
// 	}
// 	defer db.Close()
// 	err = db.View(func(tx *bolt.Tx) error {
// 		b := tx.Bucket([]byte(bucketName))
// 		value := b.Get([]byte(currentRecipePath))
// 		if value == nil {
// 			return fmt.Errorf("Couldnt find value for the key: %s", currentRecipePath)
// 		}
// 		err = protobuf.Unmarshal(value, recipe)
// 		return err
// 	})
// 	return recipe, err
// }

// func PutRecipe(ctx context.Context, recipe *proto.Recipe) error {
// 	db, err := bolt.Open(pathDB, 0600, nil)
// 	if err != nil {
// 		return err
// 	}
// 	defer db.Close()
// 	if recipe.Uuid == "" {
// 		return fmt.Errorf("A recipe cannot be put without a UUID\n")
// 	}
// 	bytes, err := protobuf.Marshal(recipe)
// 	if err != nil {
// 		return err
// 	}
// 	err = db.Update(func(tx *bolt.Tx) error {
// 		b := tx.Bucket([]byte(bucketName))
// 		err = b.Put([]byte(recipe.GetUuid()), bytes)
// 		return err
// 	})
// 	if err != nil {
// 		log.Printf("Error when setting recipe in storage: %v\n", err)
// 	}
// 	log.Printf("Put a recipe at %v\n", recipe.GetUuid())
// 	return err
// }

// func GetRecipe(ctx context.Context, uuid string) (*proto.Recipe, error) {
// 	recipe := &proto.Recipe{}
// 	var value []byte
// 	db, err := bolt.Open(pathDB, 0600, nil)
// 	if err != nil {
// 		return recipe, err
// 	}
// 	defer db.Close()
// 	err = db.View(func(tx *bolt.Tx) error {
// 		b := tx.Bucket([]byte(bucketName))
// 		value = b.Get([]byte(uuid))
// 		if value == nil {
// 			return fmt.Errorf("Couldnt find the value of key: %s", uuid)
// 		}
// 		return nil
// 	})
// 	if err != nil {
// 		log.Printf("Error getting the recipe %s in storage: %v\n", uuid, err)
// 	}
// 	err = protobuf.Unmarshal(value, recipe)
// 	return recipe, err
// }

func GetAllRecipes(ctx context.Context) ([]*proto.Recipe, error) {
	var recipes []*proto.Recipe
	// db, err := badger.Open(badger.DefaultOptions(pathDB))
	// if err != nil {
	// 	return recipes, err
	// }
	// defer db.Close()
	// log.Printf("Opened recipes store at %s", pathDB)
	// err = db.View(func(txn *badger.Txn) error {
	// 	opts := badger.DefaultIteratorOptions
	// 	opts.PrefetchSize = 10
	// 	it := txn.NewIterator(opts)
	// 	defer it.Close()
	// 	for it.Rewind(); it.Valid(); it.Next() {
	// 		item := it.Item()
	// 		if string(item.Key()) == currentRecipePath {
	// 			continue
	// 		}
	// 		value, err := item.ValueCopy(nil)
	// 		if err != nil {
	// 			return err
	// 		}
	// 		recipe := &proto.Recipe{}
	// 		err = protobuf.Unmarshal(value, recipe)
	// 		if err != nil {
	// 			return err
	// 		}
	// 		recipes = append(recipes, recipe)
	// 	}

	// 	return nil
	// })
	return recipes, nil
}

func SelectRecipe(ctx context.Context, uuid string) error {
	// db, err := badger.Open(badger.DefaultOptions(pathDB))
	// if err != nil {
	// 	return err
	// }
	// defer db.Close()
	// log.Printf("Opened recipes store at %s", pathDB)
	// // Update the current recipe key in the DB
	// err = db.Update(func(txn *badger.Txn) error {
	// 	err := txn.Set([]byte(currentRecipePath), []byte(uuid))
	// 	return err
	// })
	// if err != nil {
	// 	return err
	// }
	// // Send the recipe to microcontroller
	// recipe, err := GetRecipe(ctx, uuid)
	// for _, str := range recipeToString(recipe) {
	// 	serial.SendString(str)
	// }
	// log.Printf("Selected a new recipe %s\n", uuid)
	return nil
}

// func GetDefaultRecipe(ctx context.Context) *proto.Recipe {
// 	_, err := os.Stat(util.PathRecipe)
// 	if !os.IsNotExist(err) {
// 		log.Printf("Default recipe exist in DB")
// 		recipe, err := GetRecipe(ctx, `default`)
// 		if err != nil {
// 			log.Printf("Error: %s\n", err.Error())
// 		}
// 		return recipe
// 	}
// 	return nil
// 	// log.Printf("Default recipe not exist in DB")
// 	// return configuration.GetDefaultRecipe(ctx)
// }

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
