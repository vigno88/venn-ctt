// +build mock

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

// settingServiceServer is implementation of proto.settingServiceServer proto interface
type settingServiceServer struct {
}

func NewSettingServiceServer() proto.SettingServiceServer {
	return &settingServiceServer{}
}

// createRecipe asks the server to create a new recipe in the backend
func (s *settingServiceServer) CreateRecipe(ctx context.Context, e *proto.Empty) (*proto.Recipe, error) {
	currentRecipe, err := recipe.GetCurrentRecipe(ctx)
	if currentRecipe.Uuid == "" {
		return recipe.GetDefaultRecipe(ctx), nil
	}
	if err != nil {
		return &proto.Recipe{}, err
	}
	newRecipe := currentRecipe
	newRecipe.Uuid = util.GetNewUUID(ctx)
	return newRecipe, nil
}

// 	// Get current recipe
// 	r, err := recipe.GetRecipe(ctx, "default")
// 	if err != nil {
// 		fmt.Printf("Error when getting current recipe: %v\n", err)
// 		return &proto.Empty{}, err
// 	}
// 	// Modify the setting
// 	for i, s := range r.Settings {
// 		if s.Name == setting.Name {
// 			r.Settings[i] = setting
// 		}
// 	}
// 	// Update the recipe
// 	err = recipe.PutRecipe(ctx, r)
// 	if err != nil {
// 		fmt.Printf("Error when storing new recipe: %v\n", err)
// 	}

// 	// Send the new setting to the microcontroller
// 	serial.SendSetting(setting)

// 	return &proto.Empty{}, err
// }

// // getRecipsUUID get a list of the recipes UUID
// func (s *settingServiceServer) GetRecipesUUID(ctx context.Context, e *proto.Empty) (*proto.UUIDS, error) {
// 	// Get all the recipe
// 	recipes, err := recipe.GetAllRecipes(ctx)
// 	if err != nil {
// 		return &proto.UUIDS{}, err
// 	}
// 	var uuids []string
// 	for _, r := range recipes {
// 		uuids = append(uuids, r.GetUuid())
// 	}
// 	return &proto.UUIDS{Uuids: uuids}, nil
// }

// getRecipe gets a single recipe from the backend
func (s *settingServiceServer) ReadRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Recipe, error) {
	log.Printf("Get the recipe at path %v\n", uuid.GetValue())
	return recipe.GetRecipe(ctx, uuid.GetValue())

	// Code for testing ui purpose
	// r := recipe.GetDefaultRecipe(ctx)
	// return r, nil
}

// selectRecipe tells the backend what is the active recipe
func (s *settingServiceServer) UpdateCurrentRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Empty, error) {
	return &proto.Empty{}, recipe.SelectRecipe(ctx, uuid.String())
}

func (s *settingServiceServer) UpdateSetting(ctx context.Context, u *proto.SettingUpdate) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) UpdateUncertainty(ctx context.Context, u *proto.TargetUpdate) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) UpdateSelectedChoice(ctx context.Context, u *proto.SelectorUpdate) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) UpdateChoice(ctx context.Context, u *proto.ChoiceUpdate) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) ReadRecipesUUID(ctx context.Context, u *proto.Empty) (*proto.UUIDS, error) {
	return nil, nil
}

func (s *settingServiceServer) UpdateRecipe(ctx context.Context, u *proto.Recipe) (*proto.Empty, error) {
	return nil, nil
}
