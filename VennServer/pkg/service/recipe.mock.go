// +build mock

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/serial"
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
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Recipe{}, err
	}
	newRecipe := recipe.ToProto(r)
	newRecipe.Uuid = util.GetNewUUID(ctx)
	return newRecipe, nil
}

// getRecipe gets a single recipe from the backend
func (s *settingServiceServer) ReadRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Recipe, error) {
	r, err := recipe.ReadRecipe(uuid.GetValue())
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", uuid.GetValue(), err.Error())
		return &proto.Recipe{}, err
	}
	return recipe.ToProto(r), nil
}

// selectRecipe tells the backend what is the active recipe
func (s *settingServiceServer) UpdateCurrentRecipe(ctx context.Context, uuid *proto.StringValue) (*proto.Empty, error) {
	return &proto.Empty{}, recipe.UpdateCurrentRecipe(uuid.GetValue())
}

func (s *settingServiceServer) UpdateSetting(ctx context.Context, u *proto.SettingUpdate) (*proto.Empty, error) {
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Empty{}, err
	}
	index := r.GetIndexSlider(u.Name)
	r.Sliders[index].Value = u.Value
	switch r.Sliders[index].Destination {
	case proto.Setting_NONE:
		break
	case proto.Setting_MICROCONTROLLER:
		serial.SendSetting(r.Sliders[index])
		break
	case proto.Setting_MOTOR:
		// motors.ProcessNewSetting(r.Sliders[index], u.Value)
		break
	}
	return &proto.Empty{}, recipe.UpdateRecipe(r)
}

func (s *settingServiceServer) UpdateUncertainty(ctx context.Context, u *proto.TargetUpdate) (*proto.Empty, error) {
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Empty{}, err
	}
	index := r.GetIndexSlider(u.Name)
	r.Sliders[index].Target.Uncertainty = u.GetValue()
	return &proto.Empty{}, recipe.UpdateRecipe(r)
}

func (s *settingServiceServer) UpdateSelectedChoice(ctx context.Context, u *proto.SelectorUpdate) (*proto.Empty, error) {
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Empty{}, err
	}
	var choice *proto.Choice
	index := r.GetIndexSelector(u.Name)
	for _, v := range r.Selectors[index].PossibleChoices {
		if v.Name == u.ChoiceName {
			choice = v
			break
		}
	}
	r.Selectors[index].SelectedChoice = choice
	return &proto.Empty{}, recipe.UpdateRecipe(r)
}

func (s *settingServiceServer) UpdateChoice(ctx context.Context, u *proto.ChoiceUpdate) (*proto.Empty, error) {
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Empty{}, err
	}
	index := r.GetIndexSelector(u.NameSelector)
	for i, v := range r.Selectors[index].PossibleChoices {
		if v.Name == u.NewChoice.Name {
			// Update the possible choice
			r.Selectors[index].PossibleChoices[i] = u.NewChoice
			// Update the selected choice if it is also the one
			if r.Selectors[index].SelectedChoice.Name == u.NewChoice.Name {
				r.Selectors[index].SelectedChoice = u.NewChoice
			}
			break
		}
	}
	return &proto.Empty{}, recipe.UpdateRecipe(r)
}

func (s *settingServiceServer) ReadRecipesUUID(ctx context.Context, e *proto.Empty) (*proto.UUIDS, error) {
	recipes, err := recipe.ReadAllRecipes()
	if err != nil {
		log.Printf("Error while reading all recipes: %s", err.Error())
		return nil, err
	}
	uuids := []string{}
	for _, r := range recipes {
		uuids = append(uuids, r.UUID)
	}
	return &proto.UUIDS{Uuids: uuids}, nil
}

func (s *settingServiceServer) UpdateRecipe(ctx context.Context, u *proto.Recipe) (*proto.Empty, error) {
	// It is only possible to modify the current recipe from the ui
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return &proto.Empty{}, err
	}
	// Update the current recipe with the attributes of the new recipe
	newR := recipe.ToRecipe(u)
	r.Info = newR.Info
	r.Name = newR.Name
	r.Selectors = newR.Selectors
	r.Sliders = newR.Sliders
	return &proto.Empty{}, recipe.UpdateRecipe(r)
}

func (s *settingServiceServer) ReadSelectorList(ctx context.Context, e *proto.Empty) (*proto.Selectors, error) {
	r, err := recipe.ReadCurrentRecipe()
	if err != nil {
		log.Printf("Error while reading this recipe %s: %s ", r.Name, err.Error())
		return nil, err
	}
	p := recipe.ToProto(r)
	return &proto.Selectors{Selectors: p.Selectors}, nil
}
