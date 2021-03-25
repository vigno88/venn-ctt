// +build mock

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	configuration "github.com/vigno88/Venn/VennServer/pkg/configuration"
)

// metricServiceServer is implementation of proto.metricServiceServer proto interface
type metricServiceServer struct {
}

var metricsChan chan *proto.MetricUpdate

func NewMetricServiceServer(c chan *proto.MetricUpdate) proto.MetricServiceServer {
	metricsChan = c
	return &metricServiceServer{}
}

func (s *metricServiceServer) ReadConfig(ctx context.Context, e *proto.Empty) (*proto.MetricConfigs, error) {
	log.Printf("Frontend ask for the configuration")
	return configuration.GetConfig(ctx), nil
}

func (s *metricServiceServer) UpdateConfig(ctx context.Context, config *proto.MetricConfigs) (*proto.Empty, error) {
	configuration.SetMetricsConfig(config)
	return &proto.Empty{}, nil
}

// Get is used to get the current set of metrics
func (s *metricServiceServer) GetAll(ctx context.Context, e *proto.Empty) (*proto.MetricUpdates, error) {
	// return metrics.GetAll(ctx)

	// Code used for testing purpose
	return &proto.MetricUpdates{Updates: []*proto.MetricUpdate{
		{Name: "Temperature 1", Value: 0.0},
		{Name: "Humidity 1", Value: 0.0},
		{Name: "Temperature 2", Value: 0.0},
		{Name: "Humidity 3", Value: 0.0},
		{Name: "Temperature 1", Value: 0.0},
		{Name: "Humidity 1", Value: 0.0},
		{Name: "Temperature 2", Value: 0.0},
		{Name: "Humidity 3", Value: 0.0},
		{Name: "Temperature 1", Value: 0.0},
		{Name: "Humidity 1", Value: 0.0},
		{Name: "Temperature 2", Value: 0.0},
		{Name: "Humidity 3", Value: 0.0},
		{Name: "Temperature 1", Value: 0.0},
		{Name: "Humidity 1", Value: 0.0},
		{Name: "Temperature 2", Value: 0.0},
		{Name: "Humidity 3", Value: 0.0},
		{Name: "Temperature 1", Value: 0.0},
		{Name: "Humidity 1", Value: 0.0},
		// {Name: "Temperature 2", Value: 0.0 },
		// {Name: "Humidity 3", Value: 0.0 },
		// {Name: "Temperature 1", Value: 0.0 },
		// {Name: "Humidity 1", Value: 0.0 },
		// {Name: "Temperature 2", Value: 0.0 },
		// {Name: "Humidity 3", Value: 0.0 },
		// {Name: "Temperature 1", Value: 0.0 },
		// {Name: "Humidity 1", Value: 0.0 },
		// {Name: "Temperature 2", Value: 0.0 },
		// {Name: "Humidity 3", Value: 0.0 },
	}}, nil

}

func (s *metricServiceServer) Subscribe(e *proto.Empty,
	stream proto.MetricService_SubscribeServer) error {
	// log.Print("Metrics Subscribe requested")
	// for {
	// 	m := <-metricsChan
	// 	// metrics.Put(context.Background(), m)
	// 	if err :=
	// 		stream.Send(&proto.Metrics{Metrics: []*proto.Metric{m}}); err != nil {
	// 		// put message back to the channel
	// 		metricsChan <- m
	// 		log.Printf("Stream connection failed: %v", err)
	// 		return nil
	// 	}
	// }
	// i := 0
	// for {
	// 	time.Sleep(500 * time.Millisecond)
	// 	m := &proto.Metric{Name: "cylinder1", Value: float64(i), Average: 12.0}
	// 	if err := stream.Send(&proto.Metrics{Metrics: []*proto.Metric{m}}); err != nil {
	// 		// put message back to the channel
	// 		metricsChan <- m
	// 		log.Printf("Stream connection failed: %v", err)
	// 		return nil
	// 	}
	// 	i++
	// 	log.Printf("Metric sent: %v", m)
	// }
	return nil
}

// func SendMetric(ctx context.Context, m *proto.Metric) {
// 	metrics.Put(ctx, m)
// 	metricsChan <- *m
// }
