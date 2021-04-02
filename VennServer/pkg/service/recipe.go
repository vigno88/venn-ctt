// +build production

package service

import (
	"context"
	"fmt"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
	serial "github.com/vigno88/Venn/VennServer/pkg/serial"
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

// getRecipe gets a single recipe from the backend
func (s *settingServiceServer) ReadRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Recipe, error) {
	log.Printf("Get the recipe at path %v\n", uuid.GetValue())

	s1 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 1", Info: "Slider 1"}
	s2 := &proto.Setting{Type: "slider", Value: 22, Max: 40, Min: 10, Name: "Slider 2", Info: "Slider 1"}
	s3 := &proto.Setting{Type: "slider", Value: 28, Max: 40, Min: 10, Name: "Slider 3", Info: "Slider 1"}
	s4 := &proto.Setting{Type: "slider", Value: 30, Max: 40, Min: 10, Name: "Slider 4", Info: "Slider 1"}
	s5 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 5", Info: "Slider 1"}
	s6 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 6", Info: "Slider 1"}
	s7 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 7", Info: "Slider 1"}
	s8 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 8", Info: "Slider 1"}
	s9 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 9", Info: "Slider 1"}
	s10 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 10", Info: "Slider 1"}
	s11 := &proto.Setting{Type: "slider", Value: 20, Max: 40, Min: 10, Name: "Slider 11", Info: "Slider 1"}

	if uuid.GetValue() == "default" {
		return &proto.Recipe{Uuid: "recipe1", Title: "Recipe 1", Info: "oatmeal recipe", Settings: []*proto.Setting{s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11}}, nil
		// return recipe.GetRecipe(ctx, uuid.GetValue())
	}
	if uuid.GetValue() == "recipe1" {
		return &proto.Recipe{Uuid: "recipe1", Title: "Recipe 1", Info: "oatmeal recipe", Settings: []*proto.Setting{s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11}}, nil
	}
	if uuid.GetValue() == "recipe2" {
		return &proto.Recipe{Uuid: "recipe2", Title: "Recipe 2", Info: "oatmeal recipe", Settings: []*proto.Setting{s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11}}, nil
	}
	if uuid.GetValue() == "recipe3" {
		return &proto.Recipe{Uuid: "recipe2", Title: "Recipe 3", Info: "oatmeal recipe", Settings: []*proto.Setting{s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11}}, nil
	}
	return nil, nil
	// Code for testing ui purpose
	// r := recipe.GetDefaultRecipe(ctx)
	// return r, nil
}

// selectRecipe tells the backend what is the active recipe
func (s *settingServiceServer) UpdateCurrentRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Empty, error) {
	return nil, nil
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

func (s *settingServiceServer) ReadRecipesUUID(ctx context.Context, e *proto.Empty) (*proto.UUIDS, error) {
	return nil, nil
}

func (s *settingServiceServer) UpdateRecipe(ctx context.Context, u *proto.Recipe) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) ReadSelectorList(ctx context.Context, e *proto.Empty) (*proto.Selectors, error) {
	return nil, nil
}

// createRecipe asks the server to create a new recipe in the backend
func (s *settingServiceServer) CreateRecipeO(ctx context.Context, e *proto.Empty) (*proto.Recipe, error) {
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

// setSetting send a single setting to backend
func (s *settingServiceServer) SetSetting(ctx context.Context, setting *proto.Setting) (*proto.Empty, error) {
	fmt.Printf("Frontend ask to modify a setting %s\n", setting.Name)

	// Get current recipe
	r, err := recipe.GetRecipe(ctx, "default")
	if err != nil {
		fmt.Printf("Error when getting current recipe: %v\n", err)
		return &proto.Empty{}, err
	}
	// Modify the setting
	for i, s := range r.Settings {
		if s.Name == setting.Name {
			r.Settings[i] = setting
		}
	}
	// Update the recipe
	err = recipe.PutRecipe(ctx, r)
	if err != nil {
		fmt.Printf("Error when storing new recipe: %v\n", err)
	}

	// Send the new setting to the microcontroller
	serial.SendSetting(setting)

	return &proto.Empty{}, err
}

// getRecipsUUID get a list of the recipes UUID
func (s *settingServiceServer) GetRecipesUUID(ctx context.Context, e *proto.Empty) (*proto.UUIDS, error) {
	// Get all the recipe
	recipes, err := recipe.GetAllRecipes(ctx)
	if err != nil {
		return &proto.UUIDS{}, err
	}
	var uuids []string
	for _, r := range recipes {
		uuids = append(uuids, r.GetUuid())
	}
	return &proto.UUIDS{Uuids: uuids}, nil
}

// getRecipe gets a single recipe from the backend
func (s *settingServiceServer) GetRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Recipe, error) {
	log.Printf("Get the recipe at path %v\n", uuid.GetValue())
	return recipe.GetRecipe(ctx, uuid.GetValue())

	// Code for testing ui purpose
	// r := recipe.GetDefaultRecipe(ctx)
	// return r, nil
}

// selectRecipe tells the backend what is the active recipe
func (s *settingServiceServer) SelectRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Empty, error) {
	return &proto.Empty{}, recipe.SelectRecipe(ctx, uuid.String())
}
