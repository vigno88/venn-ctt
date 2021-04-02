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

func (s *settingServiceServer) ReadRecipesUUID(ctx context.Context, e *proto.Empty) (*proto.UUIDS, error) {
	u := &proto.UUIDS{Uuids: []string{"recipe1", "recipe2", "recipe3"}}
	return u, nil
}

func (s *settingServiceServer) UpdateRecipe(ctx context.Context, u *proto.Recipe) (*proto.Empty, error) {
	return nil, nil
}

func (s *settingServiceServer) ReadSelectorList(ctx context.Context, e *proto.Empty) (*proto.Selectors, error) {
	choice1 := &proto.Choice{Name: "choice 1"}
	choice2 := &proto.Choice{Name: "choice 2"}
	choice3 := &proto.Choice{Name: "choice 3"}
	choice4 := &proto.Choice{Name: "choice 4"}
	choice5 := &proto.Choice{Name: "choice 5"}
	choice6 := &proto.Choice{Name: "choice 6"}

	selector1 := &proto.Selector{Name: "selector 1", SelectedChoice: choice2, PossibleChoices: []*proto.Choice{choice1, choice2, choice3}}
	selector2 := &proto.Selector{Name: "selector 2", SelectedChoice: choice5, PossibleChoices: []*proto.Choice{choice4, choice1, choice5}}
	selector3 := &proto.Selector{Name: "selector 3", SelectedChoice: choice3, PossibleChoices: []*proto.Choice{choice3, choice2, choice6}}

	return &proto.Selectors{Selectors: []*proto.Selector{selector1, selector2, selector3}}, nil
}
